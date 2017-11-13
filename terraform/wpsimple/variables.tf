# AWS settings

# variable to identify environment
variable "env" {
  type    = "string"
  default = "wpsimple"
}

# VPC/subnet first two octet CIDR to use
variable "cidr" {
 type    = "string"
 default = "10.170"
}

# SSH key pair to use.  This needs to be in AWS.
variable "keypair" {
  type    = "string"
  default = "dev"
}
 
# RDS password
variable "rds_password" {
  type = "string"
  default = "asuperrandompassword."
}

# AWS region
variable "region" {
  type    = "string"
  default = "us-east-1"
}

# if you need to define tenancy
variable "tenancy" {
  type    = "string"
  default = "default"
}

