variable "terraform_state_region" {
  type = string
}
variable "terraform_state_bucket" {
  type = string
}
variable "aws_region" {
  type = string
}
variable "environment" {
  type = string
}
variable "env" {
  type = string
}
variable "ami" {
  type    = string
  default = "ami-066a70f4924af7ba1"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "key_name" {
  type = string
}
variable "volume_size" {
  default = 30
}
variable "encrypt_root_volume" {
  default = true
}
variable "vpn_overlay_subnet" {
  default = "100.127.255.0/24"
}
