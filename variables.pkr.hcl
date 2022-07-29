variable "base_ami" {
  type    = string
  default = "amzn2-ami-kernel-5.10-hvm*"
}

variable "ami_owner_id" {
  type    = string
  default = "amazon"
}

variable "region" {
  type    = string
  default = "eu-north-1"
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "subnet_id" {
  type    = string
  default = ""
}

variable "ami_name" {
  type    = string
  default = "learn-packer-linux-aws"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ssh_username" {
  type    = string
  default = "ec2-user"
}

variable "instance_profile" {
  type    = string
  default = ""
}

variable "ssh_interface" {
  type    = string
  default = "public_ip"
}

################# LOCALS
locals {
  timestamp = formatdate("YYYY.MM.DD", timestamp())
}
