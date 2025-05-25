project = "eternal-courage-460108-d6"


vpc-name = "vpc-network"
vpc-auto_create_subnetworks = false
vpc-routing_mode = "REGIONAL"
vpc-mtu = 1460


vpc-private-subnets = [{
  name          = "private-subnets"
  ip_cidr_range = "10.0.2.0/24"
  region        = "us-west1"
}]

vpc-public-subnets = [{
  name          = "public-subnets"
  ip_cidr_range = "10.0.5.0/24"
  region        = "us-west1"
}]

vpc-firewall-rules= [{
   name        = "my-firewall-rule"
   protocol  = "tcp"
   ports     = ["80", "8080", "1000-2000"]
   source_ranges= ["0.0.0.0/0"]
   target_tags = ["my-instance"]
}]
cloud-router-name = "my-router"
cloud-nat-values = {
  name   = "my-router-nat"
 
  type   = "PUBLIC" 
#   endpoint_types = "ALL"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES"
  nat_ip_allocate_option = "AUTO_ONLY" 
  auto_network_tier = "PREMIUM" 
  
}

# Gke
cluster-values = {
  name     = "my-gke-cluster"
  location = "us-west1"
#   network            = google_compute_network.vpc_network.id
#   subnetwork         = google_compute_subnetwork.private-subnets.id
  
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  deletion_protection = true
  node_locations = [
    "us-west1-a"
  ]
}

node-pools-values = {
  name       = "my-node-pool"
  location   = "us-west1"
#   cluster    = google_container_cluster.my-cluster.name
  node_count = 1

  
  preemptible  = true
  machine_type = "e2-medium"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    # service_account = google_service_account.my-service-account.email
   oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  
}

# gce values
gce-sa-account_id = "my-custom-sa"
gce-vi-name = "my-confidential-instance"
gce-vi-zone = "us-west1-a"
gce-machine_type = "e2-micro"
gce-vi-image = "projects/ubuntu-os-cloud/global/images/family/ubuntu-2204-lts"
gce-vi-size = 10
gce-vi-type = "pd-balanced"
gce-vi-firewall-tags = ["my-instance"]

# cloud storage values
bucket-name = "my-terraform-state-storage"
bucket-location = "us-west1"
bucket-force-destroy = true
storage-class = "STANDARD"
bucket-public_access_prevention = "enforced"
bucket-uniform_bucket_level_access = true
bucket-versioning = true
bucket-softdelete-policy = 0