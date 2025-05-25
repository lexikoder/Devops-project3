resource "google_compute_network" "vpc_network" {
  name                    = var.vpc-name
  auto_create_subnetworks = var.vpc-auto_create_subnetworks
  routing_mode            = var.vpc-routing_mode
  mtu                     = var.vpc-mtu
}

resource "google_compute_subnetwork" "private-subnets" {
  for_each = { for idx, subnet in var.vpc-private-subnets : idx => subnet }
  name          = each.value.name 
  ip_cidr_range = each.value.ip_cidr_range
  region        = each.value.region 
  network       = google_compute_network.vpc_network.id
  
}

resource "google_compute_subnetwork" "public-subnets" {
  for_each = { for idx, subnet in var.vpc-public-subnets : idx => subnet }
  name          = each.value.name 
  ip_cidr_range = each.value.ip_cidr_range
  region        = each.value.region 
  network       = google_compute_network.vpc_network.id
  
}

resource "google_compute_firewall" "firewall-rules" {
  for_each = { for idx, firewall in var.vpc-firewall-rules : idx => firewall}
  name        = each.value.name
  network     = google_compute_network.vpc_network.id
  description = "Creates firewall rule targeting tagged instances"

  allow {
    protocol  = each.value.protocol
    ports     = each.value.ports 
  }

  source_ranges= each.value.source_ranges
  target_tags = each.value.target_tags
}

resource "google_compute_router" "cloud-router" {
  name    = var.cloud-router-name 
  region  = google_compute_subnetwork.private-subnets[0].region
  network = google_compute_network.vpc_network.id
}

resource "google_compute_router_nat" "cloud-nat" {
  name   = var.cloud-nat-values.name 
  router = google_compute_router.cloud-router.name
  region = google_compute_router.cloud-router.region
  type   = var.cloud-nat-values.type
#   endpoint_types = "ALL"
  source_subnetwork_ip_ranges_to_nat = var.cloud-nat-values.source_subnetwork_ip_ranges_to_nat
  nat_ip_allocate_option = var.cloud-nat-values.nat_ip_allocate_option
  auto_network_tier = var.cloud-nat-values.auto_network_tier 
}


