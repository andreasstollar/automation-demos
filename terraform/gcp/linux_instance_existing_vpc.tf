provider "google" {
  version = "~> 3.39"
  project = var.project_name
  region  = var.region
  zone    = var.zone
}

data "google_compute_image" "ubuntu_image" {
  family  = "ubuntu-2004-lts"
  project = "ubuntu-os-cloud"
}

resource "google_compute_instance" "ubuntu_2004" {
  count        = var.node_count
  #name         = var.VMName
  #when count is set, name must have an index, even if count is 1
  name         = "terraform-demo-ubuntu-${count.index + 1}"
  machine_type = var.machine_type
  tags         = ["ssh", "http", "https", "http-8080", "https-8443"]
  zone         = var.zone
  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu_image.self_link
    }
  }
  network_interface {
    network = "default"
    access_config {
    }
  }
  metadata = {
    ssh-keys = var.SshKey
  }
}

output "ubuntu_2004_ip" {
  value = google_compute_instance.ubuntu_2004[*].network_interface[0].access_config[0].nat_ip
}

