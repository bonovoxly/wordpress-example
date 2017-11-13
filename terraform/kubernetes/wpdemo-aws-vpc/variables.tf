# AWS settings

# variable for dns zone (this is a private zone, internal only)
variable "dns" {
  type    = "string"
  default = "wpdemo.internal"
}

# variable to identify environment
variable "env" {
  type    = "string"
  default = "wpdemo"
}

# VPC/subnet first two octet CIDR to use
variable "cidr" {
 type    = "string"
 default = "10.171"
}

# SSH key pair to use.  This needs to be in AWS.
variable "keypair" {
  type    = "string"
  default = "dev"
}
 
# Kubernetes cluster ID name (helps find AWS tagged resources)
variable "kubernetes_cluster_id" {
 type = "string"
 default = "wpdemo-kubernetes"
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

