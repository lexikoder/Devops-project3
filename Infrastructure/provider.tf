terraform {
  # backend "gcs"{
  #   bucket = "my-terraform-state-storage"
  #   prefix = "terraform/state"
  # }
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "6.36.1"
    }
  }
}

provider "google" {
  # Configuration options
  credentials = file("key.json")
  project     = "eternal-courage-460108-d6"
  region      = "us-west1"
}