####################################################################################
#Terraform Variables - This values are passed during runtime from Bamboo CI/CD tool
####################################################################################
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}

variable "vw_vpc_id" {}
variable "vw_subnetid" {}

variable "packer_ami_id" {}
variable "vw_insttype" {}
variable "vw_sg_source_cidr" {}

variable "inspec_user_password" {}
