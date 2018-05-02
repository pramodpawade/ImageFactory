#############################################################################
#AWS Provider - This values are passed during runtime from Bamboo CI/CD tool
#############################################################################
provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}
