# wordpress instance - subnet a
resource "aws_instance" "wordpress-a" {
  ami = "${ data.aws_ami.ubuntu.id }"
  associate_public_ip_address = true
  count = "1"
  iam_instance_profile = "${ var.env }-wordpress-profile"
  instance_type = "t2.micro"
  lifecycle {
    ignore_changes = ["ami"]
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }
  key_name = "${ var.keypair }"
  private_ip = "${ cidrhost(aws_subnet.wordpress-a.cidr_block, 10) }"
  subnet_id = "${ aws_subnet.wordpress-a.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.wordpress.id }"]
  tags {
    Name = "${ var.env }-wordpress-a-${ count.index }"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    Role = "wordpress"
    sshUser = "ubuntu"
  }
}

# wordpress instance - subnet b
resource "aws_instance" "wordpress-b" {
  ami = "${ data.aws_ami.ubuntu.id }"
  associate_public_ip_address = true
  count = "1"
  iam_instance_profile = "${ var.env }-wordpress-profile"
  instance_type = "t2.micro"
  lifecycle {
    ignore_changes = ["ami"]
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }
  key_name = "${ var.keypair }"
  private_ip = "${ cidrhost(aws_subnet.wordpress-b.cidr_block, 10) }"
  subnet_id = "${ aws_subnet.wordpress-b.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.wordpress.id }"]
  tags {
    Name = "${ var.env }-wordpress-b-${ count.index }"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    Role = "wordpress"
    sshUser = "ubuntu"
  }
}

# wordpress instance - subnet c
resource "aws_instance" "wordpress-c" {
  ami = "${ data.aws_ami.ubuntu.id }"
  associate_public_ip_address = true
  count = "1"
  iam_instance_profile = "${ var.env }-wordpress-profile"
  instance_type = "t2.micro"
  lifecycle {
    ignore_changes = ["ami"]
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = "20"
  }
  key_name = "${ var.keypair }"
  private_ip = "${ cidrhost(aws_subnet.wordpress-c.cidr_block, 10) }"
  subnet_id = "${ aws_subnet.wordpress-c.id }"
  tenancy = "${ var.tenancy }"
  vpc_security_group_ids = ["${ aws_security_group.wordpress.id }"]
  tags {
    Name = "${ var.env }-wordpress-c-${ count.index }"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    Role = "wordpress"
    sshUser = "ubuntu"
  }
}
