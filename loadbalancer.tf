# No need for external load balancer as EKS creates a load balancer for us.

# resource "aws_alb" "eks-lb" {
#   name               = "${local.name_prefix}-lb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.eks-sg.id]
#   subnets            = module.vpc.public_subnets

#   tags = local.common_tags
# }

# resource "aws_alb_target_group" "arcloudops-tg" {
#   name     = "${local.name_prefix}-tg"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = module.vpc.vpc_id

#   health_check {
#       path                = "/"
#       port                = "traffic-port"
#       protocol            = "HTTP"
#       timeout             = 5
#       interval            = 30
#       healthy_threshold   = 2
#       unhealthy_threshold = 2
#   }

#   tags = local.common_tags
# }

# resource "aws_alb_listener" "arcloudops-listener" {
#   load_balancer_arn = aws_alb.eks-lb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_alb_target_group.arcloudops-tg.arn
#   }

#   tags = local.common_tags

# }