output "load_balancer_hostname" {
  value = kubernetes_service_v1.arcloudops-store-service.status.0.load_balancer.0.ingress.0.hostname
}