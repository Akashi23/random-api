resource "digitalocean_app" "random-api" {
  spec {
    name   = "random-api"
    region = "fra"
    domain {
      name = "random-api.akashi23.me"
    }
    env {
      key   = "PORT"
      value = "8080"
    }

    service {
      name               = "random-api"
      instance_count     = 1
      instance_size_slug = "basic-xxs"
      http_port          = 8080

      image {
        registry_type = "DOCR"
        repository    = "random-api"
        tag           = "latest"
      }
    }
  }
}
