data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.arcloudops-cluster.name
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.arcloudops-cluster.name
}
