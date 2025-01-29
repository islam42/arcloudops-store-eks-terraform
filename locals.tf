locals {
  common_tags = {
    company      = "arcloudops",
    project      = "arcloudops - store",
    billing_code = "123456"
    enviorment   = terraform.workspace
  }

  bucket_name = "${local.name_prefix}-bucket"
  name_prefix = "arcloudops-store-${terraform.workspace}"

  cluster_name = "arcloudops-cluster"

  # Create a local variable for the load balancer name.
  lb_name = split("-", split(".", kubernetes_service_v1.arcloudops-store-service.status.0.load_balancer.0.ingress.0.hostname).0).0
}