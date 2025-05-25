
variable "project" {
    type = string
    
}

# vpc
variable "vpc-name" {
    type = string
    default = "vpc-network"
}

variable "vpc-auto_create_subnetworks" {
    type = bool
    default = false
}

variable "vpc-routing_mode" {
    type = string
    default = "REGIONAL"
}

variable "vpc-mtu" {
    type = number
    default = 1460
}

variable "vpc-private-subnets" {
   
  type = list(object({
    name   = string
    ip_cidr_range   = string
    region     = string
}))
}

variable "vpc-public-subnets" {
   
  type = list(object({
    name   = string
    ip_cidr_range   = string
    region     = string
}))
}

variable "vpc-firewall-rules" {
    type = list(object({
    name = string
    protocol   = string 
    ports   = list(string)
    source_ranges     = list(string) 
    target_tags = list(string)
}))
}

variable "cloud-router-name" {
    type = string
    
}

variable "cloud-nat-values" {
  type = object({
  name   = string 
 
  type   = string 
#   endpoint_types = "ALL"
  source_subnetwork_ip_ranges_to_nat = string 
  nat_ip_allocate_option = string 
  auto_network_tier = string 
  })
}

# Gke


variable "cluster-values" {
  type = object({
  name     = string 
  location = string 

  
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = bool 
  initial_node_count       = number 
  deletion_protection = bool 
  node_locations = list(string)
  })
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