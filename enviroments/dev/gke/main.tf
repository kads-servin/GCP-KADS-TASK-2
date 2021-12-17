data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google"
  project_id                 = "rd-gcp-kads"
  name                       = "gke-task-2"
  region                     = "us-central1"
  zones                      = ["us-central1-b"]
  network                    = "gke-network"
  subnetwork                 = "gke-subnet"
  ip_range_pods              = "subnet-01-secondary-01"
  ip_range_services          = "subnet-02-secondary-02"
  http_load_balancing        = false
  horizontal_pod_autoscaling = false
  network_policy             = false

  node_pools = [
    {
      name               = "node-01"
      machine_type       = "n1-standard-1"
      node_locations     = "us-central1-b"
      node_count         = 2
      local_ssd_count    = 0
      min_count          = 1
      max_count          = 2
      disk_size_gb       = 50
      disk_type          = "pd-standard"
      image_type         = "COS"
      auto_repair        = true
      auto_upgrade       = true
      preemptible        = false
      initial_node_count = 2
    },
  ]
  node_pools_labels = {
    all = {}
    node-pool-1 = {
      node-pool-1 = true
    }
  }
  node_pools_tags = {
    all = []



    node-pool-1 = [
      "node-pool-1",
    ]
  }

  depends_on = [
    google_project_service.project
  ]
}
