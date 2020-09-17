variable "access_key" {
  default = "<PUT IN YOUR AWS ACCESS KEY>"
}
variable "secret_key" {
  default = "<PUT IN YOUR AWS SECRET KEY>"
}
variable "region" {
  default = "us-west-1"
}
variable "availabilityZone" {
  default = "us-west-1a"
}
variable "node_count" {
  default = "2"
}
variable "instanceTenancy" {
  default = "default"
}
variable "dnsSupport" {
  default = true
}
variable "dnsHostNames" {
  default = true
}
variable "vpcCIDRblock" {
  default = "10.0.0.0/16"
}
variable "subnetCIDRblock" {
  default = "10.0.1.0/24"
}
variable "destinationCIDRblock" {
  default = "0.0.0.0/0"
}
variable "ingressCIDRblock" {
  type    = list
  default = ["0.0.0.0/0"]
}
variable "egressCIDRblock" {
  type    = list
  default = ["0.0.0.0/0"]
}
variable "mapPublicIP" {
  default = true
}
