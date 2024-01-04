terraform {
  /*backend "s3" {
    access_key="xxxx"
    secret_key="xxxxx"
    endpoint = "xxxx"
 key arg
    bucket = "jernej-test"
    region = "eu-central-2"
    // NExt 3 rows needs to be true, cause by default is s3 aws service
    skip_credentials_validation = true //https://stanislas.blog/2018/10/how-to-use-non-aws-s3-backend-terraform/
    skip_region_validation = true
    encrypt = true
  }*/
  required_providers {
    rancher2 = {
      source  = "rancher/rancher2"
      version = "3.1.1"
    }
  }
}

provider "rancher2" {
  api_url    = var.api_url
  access_key = var.rancher2_access_key
  secret_key = var.rancher2_secret_key
}
