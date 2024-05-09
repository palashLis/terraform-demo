resource "google_compute_instance" "demo-server" {
  name         = "backend-server"
  machine_type = "e2-medium"
  #   zone         = "europe-west4-a"
  project = "sathi-codey"

  labels = {
    environment = "dev"
  }

  boot_disk {
    auto_delete = true
    device_name = "backend-instance"

    initialize_params {
      image = "https://www.googleapis.com/compute/beta/projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20240110"
      size  = 20
      type  = "pd-balanced"
    }
  }

  network_interface {
    network = "default"
    # subnetwork = google_compute_subnetwork.primary.name
    stack_type = "IPV4_ONLY"

    access_config {
      #   nat_ip = google_compute_address.static_ip_backend.address
      // Specify an external IP address for the instance
    }
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = "sa-compute-engine@sathi-codey.iam.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/cloud-platform", "https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_vtpm                 = true
  }

  tags                = ["http-server", "https-server"]
  deletion_protection = false
}
