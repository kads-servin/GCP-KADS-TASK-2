# google_client_config and kubernetes provider must be explicitly specified like the following.
data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/private-cluster"
  project_id                 = "rd-gcp-kads"
  name                       = "gke-task-2"
  regional                   = false
  region                     = "us-central1"
  zones                      = ["us-central1-b"]
  network                    = "gke-network"
  subnetwork                 = "gke-subnet"
  ip_range_pods              = "subnet-01-secondary-01"
  ip_range_services          = "subnet-02-secondary-02"
  create_service_account     = true
  http_load_balancing        = false
  horizontal_pod_autoscaling = false
  network_policy             = false
  enable_private_endpoint    = false
  enable_private_nodes       = true
  master_ipv4_cidr_block     = "10.0.0.0/28"

  node_pools = [
    {
      name               = "node-01"
      machine_type       = "n1-standard-1"
      node_locations     = "us-central1-b"
      min_count          = 1
      max_count          = 2
      local_ssd_count    = 0
      disk_size_gb       = 50
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      service_account    = "creategkeclusters@rd-gcp-kads.iam.gserviceaccount.com"
      preemptible        = false
      initial_node_count = 2

    },
  ]

  /* master_authorized_networks = [
    {
      cidr_block   = "187.233.16.82/32"
      display_name = "internet"
    }

  ] */

  remove_default_node_pool = true


  depends_on = [
    google_project_service.project
  ]
}
