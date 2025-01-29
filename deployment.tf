# This is a sample terraform file that will deploy a deployment and service to your EKS Cluster:
# The purpose of this deployment is to deploy a simple container that will serve a webserver that will return the hostname of the container.
resource "kubernetes_deployment" "arcloudops-store-deployment" {
  metadata {
    name = "arcloudops-store"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "arcloudops-store"
      }
    }

    template {
      metadata {
        labels = {
          app = "arcloudops-store"
        }
      }

      spec {
        container {
          image = "ruanbekker/hostname"
          name  = "arcloudops-store"
          port {
            name           = "http"
            container_port = 8000
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "arcloudops-store-service" {
  metadata {
    name = "arcloudops-store"
    // if not specified, the default alb will be created by eks of type classic
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type" = "alb"
    }
  }

  spec {
    selector = {
      app = "arcloudops-store"
    }

    port {
      port        = 80
      target_port = 8000
    }

    type = "LoadBalancer"
  }
}

