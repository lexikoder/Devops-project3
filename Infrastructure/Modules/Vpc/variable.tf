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

  source_subnetwork_ip_ranges_to_nat = string 
  nat_ip_allocate_option = string 
  auto_network_tier = string 
  })
}
