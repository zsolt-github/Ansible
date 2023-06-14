terraform {
  backend "azurerm" {
    resource_group_name  = "RG-Terraform_State"
    storage_account_name = "zfterraformstates"
    container_name       = "tfstates"
    key                  = "demo-project-ansible-test.terraform.tfstate"
  }
  #  set the Storage Account Access Key (ARM_ACCESS_KEY) as an environment variable = ARM_ACCESS_KEY="<storage account access key value>"
  #  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }

    azuread = {
      source = "hashicorp/azuread"
      version = "~>2.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }

    null = {
      source = "hashicorp/null"
      version = "~>3.0"
    }

    tls = {
      source  = "hashicorp/tls"
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

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    key_vault {
      purge_soft_delete_on_destroy       = true
      purge_soft_deleted_keys_on_destroy = true
    }
  }
}
provider "azuread" {}
provider "random" {}
provider "tls" {}
provider "cloudflare" {}
provider "acme" {
  #Let's Encrypt staging enpoint
  server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
  
  #Let's Encrypt production enpoint
  #server_url = "https://acme-v02.api.letsencrypt.org/directory"
}