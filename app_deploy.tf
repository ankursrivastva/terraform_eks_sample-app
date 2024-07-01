resource "kubernetes_deployment" "fortune_api" {
  metadata {
    name      = "fortune-api"
    namespace = "default"
    labels = {
      app = "fortune-api"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "fortune-api"
      }
    }

    template {
      metadata {
        labels = {
          app = "fortune-api"
        }
      }

      spec {
        container {
          name  = "fortune-api"
          image = "ankursrivastva36/fortune-api:latest"

          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "fortune_api" {
  metadata {
    name      = "fortune-api"
    namespace = "default"
  }

  spec {
    selector = {
      app = kubernetes_deployment.fortune_api.metadata.0.labels.app
    }

    port {
      port        = 80
      target_port = 8080
    }

    type = "LoadBalancer"
  }
}

