data "google_compute_image" "ubuntu_image" {
  family  = "ubuntu-2004-lts"
  project = "ubuntu-os-cloud"
}

resource "google_compute_instance" "ubuntu_2004" {
  name         = "terraform-instance"
  machine_type = "f1-micro"
  tags         = ["ssh", "http"]
  zone         = var.zone
  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu_image.self_link
    }
  }

  network_interface {
    network    = google_compute_network.terraform_vpc.self_link
    subnetwork = google_compute_subnetwork.terraform_subnet.self_link
    access_config {
    }
  }
}

output "ubuntu_2004_ip" {
  value = google_compute_instance.ubuntu_2004.network_interface.0.access_config.0.nat_ip
}
