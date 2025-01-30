locals {
  common_tags = {
    company      = var.company,
    project      = var.project,
    billing_code = var.billing_code,
    enviorment   = terraform.workspace
  }

  bucket_name = "${local.name_prefix}-bucket"
  name_prefix = "${var.project}-${terraform.workspace}"

  cluster_name = "${var.company}-${terraform.workspace}-cluster"

  # Create a local variable for the load balancer name.
  lb_name = split("-", split(".", kubernetes_service_v1.arcloudops-store-service.status.0.load_balancer.0.ingress.0.hostname).0).0
}