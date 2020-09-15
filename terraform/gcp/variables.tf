variable "project_name" {
        default = "axiomatic-set-289615"
}
variable "region" {
     default = "us-west1"
}
variable "zone" {
     default = "us-west1-a"
}
variable "company" { 
        default = "terraform-demo"
}
variable "vpcCIDRblock" {
    default = "10.0.5.0/24"
}
variable "subnetCIDRblock" {
    default = "10.0.5.0/24"
}
# not using these right now
#variable "uc1_private_subnet" {
#        default = "10.26.1.0/24"
#}
#variable "uc1_public_subnet" {
#        default = "10.26.2.0/24"
#}
#variable "ue1_private_subnet" {
#        default = "10.26.3.0/24"
#}
#variable "ue1_public_subnet" {
#        default = "10.26.4.0/24"
#}
