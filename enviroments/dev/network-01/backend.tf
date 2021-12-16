terraform {
  backend "gcs" {
    bucket  = "rd-gcp-gcs-task-2"
    prefix  = "terraform/network"
  }
}