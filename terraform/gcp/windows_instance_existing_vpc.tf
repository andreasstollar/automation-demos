provider "google" {
  version = "~> 3.39"
  project = var.project_name
  region  = var.region
  zone    = var.zone
}

data "google_compute_image" "windows_image" {
  family  = "windows-2016"
  # family  = "windows-2016-core" # core vms have no GUI
  project = "windows-cloud"
}

resource "google_compute_instance" "windows_2016" {
  count        = var.node_count
  name         = var.VMName
  machine_type = var.machine_type
  tags         = ["rdp", "http", "https"]
  zone         = var.zone
  boot_disk {
    initialize_params {
      image = data.google_compute_image.windows_image.self_link
    }
  }
  network_interface {
    network    = "default"
    access_config {
    }
  }
  metadata = {
  }
}

output "windows_2016_ip" {
  value = google_compute_instance.windows_2016[*].network_interface[0].access_config[0].nat_ip
}

