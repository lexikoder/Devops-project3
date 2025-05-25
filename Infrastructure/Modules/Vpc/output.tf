output "vpc_id" {
  value = google_compute_network.vpc_network.id
}

output "private-subnet_id" {
  value = google_compute_subnetwork.private-subnets[0].id
}