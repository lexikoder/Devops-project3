variable "bucket-name" {
    type = string
}
variable "bucket-location" {
    type = string
}
variable "bucket-force-destroy" {
    type = bool
}
variable "storage-class" {
    type = string
}
variable "bucket-public_access_prevention" {
    type = string
}
variable "bucket-uniform_bucket_level_access" {
    type = string
}
variable "bucket-versioning" {
    type = string
}
variable "bucket-softdelete-policy" {
    type = number
}