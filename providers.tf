terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.2.1"
    }
  }
}

provider "google" {
  # Configuration options
  project     = "rd-gcp-kads"
  region      = "us-central1"
  zone        = "us-central1-a"
  credentials = "keys.json"
}
