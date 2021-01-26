variable "project_name" {
  default = "gdt-demo-1"
}
variable "region" {
  default = "us-west1"
}
variable "zone" {
  default = "us-west1-a"
}
variable "company" {
  default = "gdt-demo"
}
variable "VMName" {
  default = "TestTerraformVM"
}
variable "machine_type" {
  default = "e2-micro"
}
variable "node_count" {
  default = "1"
}
variable "SshKey" {
  # paste your ssh key here, gcp requires "<username>:<ssh-key>"
  default = "andreasstollar:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7nu9+OBzcd4LczjQkzgeVz1j3irhVuUnsFpCoPEfuTNh54H50oCnTWQ5iU/XP1mQOfHb34b5tYH7OD94QZgipKnzTvzoKTJLzmH0yp0mMTV/fWLucu6sU3rnDqd+InKEVJndLxMV+nhXO4Vlg/JcVB7G34FOPVDzcF6pCMo73paNnj5WHFE4EOsPTqrIlNhPY25KXVx2Mg0q7WyTcr95q0u2N+ic3iOx6RlfgIRmNK24TUNiAoZKEk4/Zz+ocKj7OVTGnSlfSL3DpRN5t+ZDucD/OC8JJ5HT5C/D4Wzs11+MwB9SIMTjwvHnpnMHmFa/TlxPpEtldlERa7Qe8iXO8ZZkA5f16W4Gab2H4m6QCrfoHzuA6ddITnq40KLIV3uJdoEdzsYiCP2rCchr/immI72QWupAh2+jxFmZGKor9d4J9hD7+2Z7tidiEWE/4uGs8ZP29+nGvNrHZomfG9E1brjgExPVwHA6TcZ7Dh7u6COZpiYFtd+6Vgc+DTyG/2aM= andreasstollar@Andreass-MacBook-Pro.local"
}
variable "vpcCIDRblock" {
  default = "10.0.5.0/24"
}
variable "subnetCIDRblock" {
  default = "10.0.5.0/24"
}
