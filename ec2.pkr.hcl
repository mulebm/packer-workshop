########################################## PACKER BLOCK
packer {
  required_plugins {
    amazon = {
      version = ">= 1.1.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

########################################## DATA SOURCE BLOCK
# Dynamic AMI data source
data "amazon-ami" "ami" {
  filters = {
    virtualization-type = "hvm"
    root-device-type    = "ebs"
    name                = var.base_ami
  }
  owners      = [var.ami_owner_id]
  most_recent = true
  region      = var.region
}

########################################## SOURCE BLOCK
source "amazon-ebs" "linux" {
  source_ami     = data.amazon-ami.ami.id
  ami_name       = var.ami_name
  instance_type  = var.instance_type
  region         = var.region
  vpc_id         = var.vpc_id
  subnet_id      = var.subnet_id
  user_data_file = "script.sh"

  communicator         = "ssh" # this is a default so doesn't need to be specified (unless using windows which is winrm)
  ssh_username         = var.ssh_username
  iam_instance_profile = var.instance_profile
  ssh_interface        = var.ssh_interface

  run_tags = {
    Creator = "Packer"
  }
  run_volume_tags = {
    Creator = "Packer"
  }
  snapshot_tags = {
    Creator = "Packer"
  }
  tags = {
    Name          = "${var.ami_name}-${local.timestamp}"
    Base_AMI_Name = "{{ .SourceAMIName}}"
    Creator       = "Packer"
  }
}

########################################## BUILD BLOCK
build {
  name = var.ami_name
  sources = [
    "source.amazon-ebs.linux"
  ]
}
