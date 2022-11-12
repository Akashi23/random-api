resource "digitalocean_app" "random-api" {
  spec {
    name   = "random-api"
    region = "fra"
    env {
        PORT = "8080"
    }

    service {
      name               = "random-api"
      instance_count     = 1
      instance_size_slug = "basic-xs"
      http_port = 8080

      image {
        registry_type = "DOCR"
        repository = "akashi/random-api"
        tag = "do-v1"
        deploy_on_push {
            enabled = true
        }
      }
    }
  }
}