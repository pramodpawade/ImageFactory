####################################################################################
#Terraform Variables - This values are passed during runtime from Bamboo CI/CD tool
####################################################################################
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}

variable "vm_vpc_id" {}
variable "vm_subnetid" {}

variable "packer_ami_id" {}
variable "vm_insttype" {}
variable "vm_sg_source_cidr" {}

variable "inspec_user_password" {}
