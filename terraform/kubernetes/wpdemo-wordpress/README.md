# Wordpress Terraform

Deployment of 3 Wordpress instances to different availability zones. Requires a VPC infrastructure to exist (recommended to use the `wpdemo-aws-vpc` Terraform). Deploys:

- AWS settings, such as security groups.
- an RDS instance, for the Wordpress database.

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
  
- Run Terraform:

```
terraform init
terraform plan
terraform apply
```

