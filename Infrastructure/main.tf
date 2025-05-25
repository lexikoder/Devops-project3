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

# module "my-cluster" {
# source = "./Modules/Gke"
# project = var.project
# cluster-values = var.cluster-values
# cluster-values-vpc-network-id = module.myvpc1.vpc_id
# cluster-values-private-subnetwork-id = module.myvpc1.private-subnet_id
# node-pools-values = var.node-pools-values 
# } 

module "my-virtual-instance" {
source = "./Modules/Gce"
gce-sa-account_id = var.gce-sa-account_id
gce-vi-name = var.gce-vi-name 
gce-vi-zone = var.gce-vi-zone 
gce-machine_type = var.gce-machine_type 
gce-vi-image = var.gce-vi-image
gce-vi-size = var.gce-vi-size
gce-vi-type = var.gce-vi-type
gce-vi-network = module.myvpc1.vpc_name
public-subnet-name = module.myvpc1.public-subnet_names[0]
gce-vi-firewall-tags = var.gce-vi-firewall-tags 
} 

module "my-cloud-storage" {
source = "./Modules/Gcs"
bucket-name = var.bucket-name
bucket-location = var.bucket-location
bucket-force-destroy = var.bucket-force-destroy
storage-class = var.storage-class
bucket-public_access_prevention = var.bucket-public_access_prevention 
bucket-uniform_bucket_level_access = var.bucket-uniform_bucket_level_access
bucket-versioning = var.bucket-versioning
bucket-softdelete-policy = var.bucket-softdelete-policy
} 



