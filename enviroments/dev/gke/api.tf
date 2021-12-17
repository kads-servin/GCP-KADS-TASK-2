resource "google_project_service" "project" {
  project = "rd-gcp-kads"
  service = "container.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = false
  disable_on_destroy         = false
}