variable "project" {
    type = string
    
}


variable "cluster-values" {
  type = object({
  name     = string 
  location = string 
#   network            = string google_compute_network.vpc_network.id
#   subnetwork         = string google_compute_subnetwork.private-subnets.id
  
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = bool 
  initial_node_count       = number 
  deletion_protection = bool 
  node_locations = list(string)
  })
}

variable "cluster-values-vpc-network-id" {
    type = string 
   
}

variable "cluster-values-private-subnetwork-id" {
  type = string  

} 



variable "node-pools-values" {
  type = object({
  name       = string 
  location   = string 
  node_count = number 


    preemptible  = bool 
    machine_type = string 

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    # service_account = string google_service_account.my-service-account.email
    oauth_scopes    = list(string) 
  
  
  })
}
