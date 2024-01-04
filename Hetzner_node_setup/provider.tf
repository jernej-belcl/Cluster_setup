terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.43.0"
    }

    time = {
      source = "hashicorp/time"
      version = "~> 0.6.0"
    }
  }
}

provider "hcloud" {
  # Configuration options
  token   = var.hcloud_token
}
