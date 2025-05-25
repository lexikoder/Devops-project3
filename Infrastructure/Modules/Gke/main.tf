# Gke
resource "google_service_account" "my-service-account" {
  account_id   = "node-pools-service-account" 
}
# locals {
#   role = [
# {role    = "roles/iam.serviceAccountUser"}, 
# {role    = "roles/compute.instanceAdmin"}, 
# {role    = "roles/container.nodeServiceAccount"}]

# }
# resource "google_project_iam_member" "sa_service_account_user" {
#      for_each = { for idx, myaddon in local.role : idx => myaddon }
#      project = var.project 
#      role    = each.value.role
#      member  = "serviceAccount:${google_service_account.my-service-account.email}"
# }


resource "google_container_cluster" "my-cluster" {
  name     = var.cluster-values.name
  location = var.cluster-values.location 
  network            = var.cluster-values-vpc-network-id
  subnetwork         = var.cluster-values-private-subnetwork-id
  
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = var.cluster-values.remove_default_node_pool 
  initial_node_count       = var.cluster-values.initial_node_count 
  deletion_protection = var.cluster-values.deletion_protection 
  node_locations = var.cluster-values.node_locations 
}

resource "google_container_node_pool" "node-pools" {
  name       = var.node-pools-values.name 
  location   = var.node-pools-values.location
  cluster    = google_container_cluster.my-cluster.name
  node_count = var.node-pools-values.node_count 

  node_config {
    preemptible  = var.node-pools-values.preemptible 
    machine_type = var.node-pools-values.machine_type

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.my-service-account.email
    oauth_scopes    = var.node-pools-values.oauth_scopes 
    
  }
}