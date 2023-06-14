terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "~>3.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "~>4.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~>4.0"
    }
    acme = {
      source  = "vancluever/acme"
      version = "~> 2.0"
    }
  }
}

