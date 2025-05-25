module "myvpc1" {
source = "./Modules/Vpc"
vpc-name = var.vpc-name
vpc-auto_create_subnetworks = var.vpc-auto_create_subnetworks
vpc-routing_mode = var.vpc-routing_mode
vpc-mtu = var.vpc-mtu
vpc-private-subnets = var.vpc-private-subnets
vpc-public-subnets = var.vpc-public-subnets
vpc-firewall-rules = var.vpc-firewall-rules
cloud-router-name = var.cloud-router-name
cloud-nat-values = var.cloud-nat-values
}

module "my-cluster" {
source = "./Modules/Gke"
project = var.project
cluster-values = var.cluster-values
cluster-values-vpc-network-id = module.myvpc1.vpc_id
cluster-values-private-subnetwork-id = module.myvpc1.private-subnet_id
node-pools-values = var.node-pools-values 
} 