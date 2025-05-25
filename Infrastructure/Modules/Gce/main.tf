resource "google_service_account" "service-account" {
  account_id   = var.gce-sa-account_id
  
}

resource "google_compute_instance" "virtual_instance" {
  name             = var.gce-vi-name
  zone             = var.gce-vi-zone
  machine_type     = var.gce-machine_type
#   min_cpu_platform = "AMD Milan"

  boot_disk {
    initialize_params {
      image = var.gce-vi-image
      size = var.gce-vi-size 
      type  = var.gce-vi-type
    }
  }

  network_interface {
    network = var.gce-vi-network 
    subnetwork = var.public-subnet-name
    access_config {
      // Ephemeral public IP
    }
  }

  tags = var.gce-vi-firewall-tags 

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.service-account.email
    scopes = ["cloud-platform"]
  }
}