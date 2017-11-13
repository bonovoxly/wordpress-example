# wordpress-example

This repository tracks the deployment and orchestration of a Wordpress site. This wordpress site will consist of two core services; a stateless Wordpress service and a MySQL datastore. This repository includes the following:

- Provide a Wordpress deployment locally, using docker-compose.
- Provide a Wordpress deployment to AWS, using Terraform and Ansible. Terraform is used to provision the infrastructure and Ansible for configuration.
- Kubernetes Wordpress deployment yaml and service yaml files.
- Provide a Wordpress deployment to Kubernetes, including the Kubernetes provisioning. The Terraform and Ansible deployments and configurations for all AWS infrastructure is provided, but the focus should be on the simplicity of deploying using Kubernetes deployment and service files.

While Kubernetes could be considered overkill for JUST a Wordpress deployment, they are useful in cases where organizations are already using Kubernetes for container orchestration for other services and work.

## Requirements

- Terraform (tested on version .0.10.x or greater)
- Ansible (tested on 2.4.x)
- Working AWS credentials, including the AWS access key and AWS secret key. These should be set as environment variables and should look like this:

```
AWS_ACCESS_KEY_ID=YOURACCESSKEY
AWS_SECRET_ACCESS_KEY=YOURSECRETKEY
```

This will allow Terraform and Ansible to create and configure the necessary infrastructure.

# local docker-compose

The first step is to run a local docker-compose. This is based on the most simple example, [found here](https://docs.docker.com/compose/wordpress/#define-the-project).

To run locally:

```
docker-compose up
```

After that, connect to http://localhost:8000 with your preferred browser. Wordpress should be up and running.

# AWS Instances, RDS, and an ELB

This is a straighforward example of a Wordpress deployment to AWS. IT is composed of:

- An AWS infrastructure, including a VPC, subnets, security groups, Internet Gateway, instances, and ELB.
- An Internet facing ELB.
- Three Wordpress EC2 instances that the ELB connects to (all in different Availability Zones).
- An Amazon RDS MySQL DB. The Wordpress instances connect to this DB.


The following Terraform + Ansible playbook deploys that particular infrastructure.

## Terraforming the Wordpress AWS environment

This particular deployment creates a unique VPC

- In the `terraform/wsimple` directory, there are variables and settings for the MySQL settings (such as the password). Edit accordingly.
- Deploy the Wordpress infrastructure using Terraform:

```
cd terraform/wpsimple
source ../aws_credentials.sh # if you don't have environment variables set, this will get them from your ~/.aws/config
terraform init
terraform plan
terraform apply
```

## Use Ansible to Configure the Instances

With the infrastructure provisioned, Ansible is used to configure the software on those instances.

- Go to the `ansible` directory:

```
cd ansible
```

- Optional - Gather the SSH public keys from the AWS System Console. Useful to securely get trust the public SSH keys on the instances ([more info on why I do this here, if you're interested](https://blog.billyc.io/2017/07/30/gathering-public-ssh-keys-from-the-aws-system-log-and-creating-custom-ssh-host-entries-using-ansible/)):

```
ansible-playbook localhost_ssh_scan.yml -e region=us-east-1
```

(note that if done quickly after Terraforming, the AWS System Log may not be created yet and the SSH key might be "missed"...)

- If you then look at your `~/.ssh/known_hosts` file, you should see three entries like so:

```
wpsimple-wordpress-a-0,ip-10-170-4-10.ec2.internal,10.170.4.10,54.174.33.253 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBMq0Yy0HuSi6RA69IvoWklMr7EFNWccRJqYyGqgglCFcEvLF3NLQSo29t2ZVa3uXe3SRbB/wsryNa8v8gzolG5g= # us-east-1 - wpsimple-wordpress-a-0 - ansible generated
wpsimple-wordpress-b-0,ip-10-170-5-10.ec2.internal,10.170.5.10,34.206.54.233 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBDZbwQZbVhnzh8ptV246DwNGgyMv9GfVTJ+xFCUxOnb8SKhFGPJp8GawIAmF484jn05NRZPuxlysrVR+5CG7Dpo= # us-east-1 - wpsimple-wordpress-b-0 - ansible generated
wpsimple-wordpress-c-0,ip-10-170-6-10.ec2.internal,10.170.6.10,34.230.42.48 ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBGMCTXkii32VqJCpXVcK3cUjiAChAp+o6lrpyP+uq4rTS0hbgLLCUJXOMPQE1DWPCYq0eU611nEYrIRtGjMWThY= # us-east-1 - wpsimple-wordpress-c-0 - ansible generated

```

- If necessary, edit the `inventory/wpsimple/group_vars/all/rds.yml` file. This contains variables such as the password to the MySQL RDS instance. Defaults should allow it to work out of the box.
- Then run the Ansible playbook to configure the instances (note it uses the EC2 dynamic inventory script, to "find" the public IP addresses of the Wordpress instances):

```
ansible-playbook -i inventory/wpsimple/ec2.py wordpress_simple.yml
```

- After that, go to the AWS Console, get the DNS entry for the AWS ELB and access it using your preferred web browser. Wordpress should be operational.

# Kubernetes Deployment - Existing Infrastructure

I've included some Kubernetes files. If an existing Kubernetes deployment is in place, there are only a few steps needed to deploy a Wordpress environment. Note that this particular setup deploys a Kubernetes Wordpress deployment and a Kubernetes loadbalancer service (exposing the service to the Internet via an AWS ELB).

- Deploy the AWS RDS MySQL instance.
- Edit the Kubernetes Wordpress deployment file. Modify the environment variables to match the MySQL host, username, and password.
- Deploy the Wordpress Kubernetes deployment and service:

```
cd kubernetes
kubectl create -f wordpress-deployment.yml
kubectl create -f wordpress-service.yml
```

- Check which ELB has been provisioned for the service. Wordpress should be operational.

# Kubernetes Deployment - From Zero

In order to test the Kubernetes deployment, a Kubernetes environment is needed. I decided to include the steps that I have used ([this is reused code from a custom Kubernetes deployment I've previously used](https://blog.billyc.io/2017/08/21/deploying-kubernetes-1.7.3-using-terraform-and-ansible/)).

## Terraform the Infrastructure

Again, you'll need Terraform and Ansible installed, with proper AWS credential configured.

- Terraform the AWS VPC infrastructure:

```
cd terraform/kubernetes/wpdemo-aws-vpc
terraform init
terraform plan
terraform apply
```

- Terraform the Kubernetes infrastructure:

```
cd terraform/kubernetes/wpdemo-kubernetes
terraform init
terraform plan
terraform apply
```

- Terraform the Wordpress infrastructure:

```
cd terraform/kubernetes/wpdemo-wordpress
terraform init
terraform plan
terraform apply
```

Now on to Ansible to configure the infrastructure.

## Ansible Configuration

This Ansible playbook configures the Kubernetes + Wordpress RDS DB infrastructure. Note it uses the inventory `inventory/wpdemo`.

- Go to the `ansible` directory:

```
cd ansible
```

- Optional - Gather the SSH public keys from the AWS System Console ([Again, info on why I do this here, if you're interested](https://blog.billyc.io/2017/07/30/gathering-public-ssh-keys-from-the-aws-system-log-and-creating-custom-ssh-host-entries-using-ansible/)):

```
ansible-playbook localhost_ssh_scan.yml -e region=us-east-1
```

- Configure the OpenVPN instance. This uses the EC2 dynamic inventory script:

```
ansible-playbook -i inventory/wpdemo/ec2.py openvpn_deploy.yml
```

- This will drop an OpenVPN configuration on the desktop. Install it using your favorite OpenVPN client.

All of the rest of the steps will require VPN access.

- Deploy the CFSSL instance. I use this to generate SSL certificates. One day I'll research replacing this with Hashicorp Vault...

```
ansible-playbook -i inventory/wpdemo/inventory cfssl_deploy.yml
```

- Now to deploy Kubernetes.

```
ansible-playbook -i inventory/wpdemo/inventory kubernetes_deploy.yml
```

This should drop a Kubernetes kubeconfig file on the desktop. It might require editing and changing:

```
server: https://wpdemo-controller.wpdemo.internal:6443
# change this line to
server: https://10.171.21.10:6443
```

(This is due to OpenVPN not updating DNS to use AWS internal resolution)

- Configure `kubectl` accordingly. Verify connectivity with:

```
kubectl get nodes
```

- Kubernetes is configured and deployed.
- To deploy the Wordpress deployment, go to `kubernetes` and using kubectl, deploy:

```
cd kubernetes
kubectl create -f wordpress-deployment.yml
kubectl create -f wordpress-service.yml
```

- Check which ELB has been provisioned for the service. Wordpress should be operational.

# Summary

This did exceed the initial ask, but I wanted to include some additional infrastructure. This comes from the fact that deploying stateless services benefit greatly from using some container orchestration platform (Mesos, Rancher, Docker Swarm, etc). In this singular example, it is overkill. However, most organizations don't have only one stateless service stack, but many. Having a platform like Kubernetes to manage them is extremely useful and thus, I wanted to include some demonstrations on how I would use Wordpress on an infrastructure like that.

Thank you for your time.

Bill

# Issues, Limitations, and Design Decisions

- Normally, I would create all instances as private, but for the sake of simplicity, I chose to use public instances. The Kubernetes infrastructure uses an OpenVPN instance.
- For costs sake, I deployed an RDS instance that was NOT multi-AZ. For production level infrastructure, a multi-AZ RDS deployment should be created.
- The instances do not maintain a shared session (this includes the Kubernetes deployment). This forces uses to authenticate multiple times. There are a couple ways to solve and reduce this. My preferred way is to use either Memcache or Redis. Another way is to write the state to a shared storage (NFS or AWS EFS). Future improvement would be to solve the PHP/Wordpress session issue.
- For Terraforming and Ansible playbooks, I like to break them up into logical pieces. For instance, the VPC Terraform is seperate from the Kubernetes and Wordpress infrastructure. Makes things easier to manage, as opposed to a giant blob of infra deployed all at once.
- I have historically used the [NGINX Ingress Controller](https://github.com/kubernetes/ingress-nginx). A single `ELB --> NGINX` layer is much nicer than a new ELB for every service you want to expose publically. I would have liked to have provided this NGINX ingress Kubernetes yaml.
