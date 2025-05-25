resource "google_storage_bucket" "cloud-bucket" {
  name          = var.bucket-name 
  location      = var.bucket-location
  force_destroy = var.bucket-force-destroy
  storage_class = var.storage-class
  public_access_prevention = var.bucket-public_access_prevention
  uniform_bucket_level_access = var.bucket-uniform_bucket_level_access
  versioning {
    enabled = var.bucket-versioning
  }
  soft_delete_policy {

    retention_duration_seconds = var.bucket-softdelete-policy

  }
}

