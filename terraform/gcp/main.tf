provider "google" {
  version = "~> 3.39"
  project = var.project_name
  region  = var.region
  zone    = var.zone
}

# Create the VPC
resource "google_compute_network" "terraform_vpc" {
  name                    = format("%s", "${var.company}-vpc")
  auto_create_subnetworks = "false"
  routing_mode            = "GLOBAL"
}

# Create the Subnet
resource "google_compute_subnetwork" "terraform_subnet" {
  name          = format("%s", "${var.company}-${var.region}-subnet")
  ip_cidr_range = var.subnetCIDRblock
  network       = google_compute_network.terraform_vpc.self_link
  region        = var.region
}

# Set up firewall rules
resource "google_compute_firewall" "allow-internal" {
  name    = "${var.company}-fw-allow-internal"
  network = google_compute_network.terraform_vpc.name
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  source_ranges = [
    var.subnetCIDRblock,
  ]
}
resource "google_compute_firewall" "allow-http" {
  name    = "${var.company}-fw-allow-http"
  network = google_compute_network.terraform_vpc.name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  target_tags = ["http"]
}
resource "google_compute_firewall" "allow-ssh" {
  name    = "${var.company}-fw-allow-ssh"
  network = google_compute_network.terraform_vpc.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["ssh"]
}
