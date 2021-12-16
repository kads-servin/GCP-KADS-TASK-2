module "vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 3.0"

    project_id   = var.project_id
    network_name = var.network_name
    routing_mode = var.routing_mode

    subnets = [
        {
            subnet_name           = var.subnet_name
            subnet_ip             = var.subnet_ip
            subnet_region         = var.subnet_region
        }
    ]

    secondary_ranges = {
        subnet-01 = [
            {
                range_name    = "subnet-01-secondary-01"
                ip_cidr_range = "192.168.50.0/24"
            },
            {
                range_name    = "subnet-02-secondary-02"
                ip_cidr_range = "192.168.60.0/24"
            },

        ]
    }
}