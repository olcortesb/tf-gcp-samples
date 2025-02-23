terraform {
  required_version = "~> 1.10.5"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.34.0"
    }
  }
}

provider "google" {
  project = "terraform-functions"
  region  = "us-central1"
}