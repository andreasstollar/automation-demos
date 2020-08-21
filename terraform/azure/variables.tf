variable "region" {
     default = "westus2"
}
variable "ResourceGroup" {
    default = "Terraform_Demo_Resource_Group"
}
variable "SecurityGroup" {
    default = "Terraform_Demo_Security_Group"
}
variable "Environment" {
    default = "Terraform Demo"
}
variable "Vnet" {
    default = "Terraform_Demo_Vnet"
}
variable "Subnet" {
    default = "Terraform_Demo_Subnet"
}
variable "PublicIP" {
    default = "Terraform_Demo_PublicIP"
}
variable "SshKey" {
    # paste your ssh key here
    default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC7nu9+OBzcd4LczjQkzgeVz1j3irhVuUnsFpCoPEfuTNh54H50oCnTWQ5iU/XP1mQOfHb34b5tYH7OD94QZgipKnzTvzoKTJLzmH0yp0mMTV/fWLucu6sU3rnDqd+InKEVJndLxMV+nhXO4Vlg/JcVB7G34FOPVDzcF6pCMo73paNnj5WHFE4EOsPTqrIlNhPY25KXVx2Mg0q7WyTcr95q0u2N+ic3iOx6RlfgIRmNK24TUNiAoZKEk4/Zz+ocKj7OVTGnSlfSL3DpRN5t+ZDucD/OC8JJ5HT5C/D4Wzs11+MwB9SIMTjwvHnpnMHmFa/TlxPpEtldlERa7Qe8iXO8ZZkA5f16W4Gab2H4m6QCrfoHzuA6ddITnq40KLIV3uJdoEdzsYiCP2rCchr/immI72QWupAh2+jxFmZGKor9d4J9hD7+2Z7tidiEWE/4uGs8ZP29+nGvNrHZomfG9E1brjgExPVwHA6TcZ7Dh7u6COZpiYFtd+6Vgc+DTyG/2aM= andreasstollar@Andreass-MacBook-Pro.local"
}
variable "vpcCIDRblock" {
    default = "10.0.5.0/24"
}
variable "subnetCIDRblock" {
    default = "10.0.5.0/26"
}
