variable "gce-sa-account_id" {
    type = string
}
variable  "gce-vi-name" {
    type = string
}
variable "gce-vi-zone" {
    type = string
}
variable "gce-machine_type" {
    type = string
}
variable "gce-vi-image" {
    type = string
}
variable "gce-vi-size"{
    type = number
}
variable "gce-vi-type" {
    type = string
}
variable "gce-vi-network" {
    type = string
}
variable "public-subnet-name" {
    type = string
}
variable "gce-vi-firewall-tags" {
    type = list(string)
}