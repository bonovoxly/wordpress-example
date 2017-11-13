# wpsimple deployment

This Terraform project deploys a very simple Wordpress environment to AWS. Total resources deployed:

- A VPC
- Multiple subnets (Wordpress and DB subnets, in multiple Availability Zones)
- an Internet Gateway
- an AWS ELB
- 3 Wordpress instances (in different AZs)
- A Wordpress IAM profile (for all 3 instances)
- A MySQL RDS instance


# quick start

- Export your AWS keys (note - if you have your credentials saved at `~/.aws/config`, you can just source the source script, `source ../source_credentials.sh`).

```
export AWS_ACCESS_KEY_ID=YOURACCESSKEY
export AWS_SECRET_ACCESS_KEY=YOURSECRETKEY
```

- Edit the `variables.tf` accordingly.  Some important ones:
  - `dns` - internal DNS zone to use
  - `env` - the environment, used for tagging/labeling instances.
  - `cidr` - the first two octets of the AWS VPC cidr.  
  - `keypair` - this should be the public SSH key that manages the instances.  Needs to exist in AWS.
  - `rds_password` - the admin AWS MySQL RDS password.
  
- Run Terraform:

```
terraform init
terraform plan
terraform apply
```

