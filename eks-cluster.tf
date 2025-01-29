# Purpose: Create EKS cluster

resource "aws_iam_role" "eks_assume_role" {
  name = "${local.cluster_name}-eks-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "arcloudops-eks-cluster-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_assume_role.name
}

resource "aws_eks_cluster" "arcloudops-cluster" {
  name     = local.cluster_name
  role_arn = aws_iam_role.eks_assume_role.arn

  vpc_config {
    subnet_ids = concat(module.vpc.public_subnets, module.vpc.private_subnets)
    # security_group_ids = [aws_security_group.eks.id]
  }

  depends_on = [aws_iam_role_policy_attachment.arcloudops-eks-cluster-policy]

  lifecycle {
    create_before_destroy = true
  }
  version = var.eks_version
  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  tags = local.common_tags
}

resource "aws_eks_node_group" "arcloudops-node-group" {
  cluster_name    = aws_eks_cluster.arcloudops-cluster.name
  node_group_name = "${local.cluster_name}-nodegroup"
  node_role_arn   = aws_iam_role.eks_node_role.arn

  subnet_ids = module.vpc.public_subnets

  instance_types = [var.aws_instance_type]

  scaling_config {
    desired_size = var.node_desired_capacity
    max_size     = var.node_maximum_capacity
    min_size     = var.node_minumum_capacity
  }

  // for rolling updates and zero downtime deployments
  update_config {
    max_unavailable = 1
  }

  lifecycle {
    # no need to create a new node group before destroying the old one for zero downtime deployments, because
    # the max unavailable is set to 1
    # The Node group name should be dynamic, otherwise, it will throw an error when you try to create a new node group with the same name.
    # create_before_destroy = true
    ignore_changes = [scaling_config[0].desired_size]
  }

  tags = merge(local.common_tags, {
    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
  })

  depends_on = [aws_iam_role.eks_assume_role]
}

resource "aws_iam_role" "eks_node_role" {
  name = "${local.cluster_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_node_role_policy" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
  ])

  role       = aws_iam_role.eks_node_role.name
  policy_arn = each.value
}

