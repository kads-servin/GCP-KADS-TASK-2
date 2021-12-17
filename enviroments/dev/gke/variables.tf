variable "project_id" {
  default     = "rd-gcp-kads"
  description = "Project Id in GCP"
}
variable "network_name" {
  default     = "gke-network"
  description = "Name of the new network"
}
variable "subnet_name" {
  default     = "gke-subnet"
  description = "Name of the subnet"
}