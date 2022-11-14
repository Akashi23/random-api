terraform {
  backend "s3" {
    endpoint                    = "https://terraformstatesaves.fra1.digitaloceanspaces.com"
    key                         = "terraform.tfstate"
    bucket                      = "rappiddev-terraform-remote-state"
    region                      = "fra1"
    skip_metadata_api_check     = true
  }
}


resource "digitalocean_app" "random-api" {
  spec {
    name   = "random-api"
    region = "fra"
    domain {
      name = "random-api.akashi23.me"
      type = "PRIMARY"
      zone = "akashi23.me"
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
