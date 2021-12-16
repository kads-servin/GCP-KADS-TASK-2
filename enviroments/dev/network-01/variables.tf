variable "project_id" {
    default = "rd-gcp-kads"
    description = "Project Id in GCP"
}

variable "network_name" {
    default = "gke-network"
    description = "Name of the new network"
}

variable "routing_mode" {
    default = "GLOBAL"
    description = ""
}
variable "subnet_name" {
    default = "gke-subnet"
    description = "Name of the subnet"
}

variable "subnet_ip" {
    default = "10.10.20.0/24"
    description = "Name of the subnet"
}

variable "subnet_region" {
    default = "us-central1"
    description = "Type of region that we are going to define"
}
