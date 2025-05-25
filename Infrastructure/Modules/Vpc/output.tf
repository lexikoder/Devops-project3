output "vpc_name" {
  value = google_compute_network.vpc_network.name
}

output "vpc_id" {
  value = google_compute_network.vpc_network.id
}

output "private-subnet_id" {
  value = google_compute_subnetwork.private-subnets[0].id
}

output "public-subnet_names" {
  value = [for subnet in google_compute_subnetwork.public-subnets : subnet.name]
}