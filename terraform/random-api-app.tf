terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_app" "random-api" {
  spec {
    name   = "random-api"
    region = "fra"
    domain = {
        name = "akashi23.me"
    }
    env {
      key   = "PORT"
      value = "8080"
    }

    service {
      name               = "random-api"
      instance_count     = 1
      instance_size_slug = "basic-xs"
      http_port          = 8080

      image {
        registry_type = "DOCR"
        repository    = "akashi/random-api"
        tag = "latest"
      }
    }
  }
}
