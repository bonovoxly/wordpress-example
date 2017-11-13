# Wordpress security group
resource "aws_security_group" "wordpress" {
  description = "${ var.env } Wordpress security group"
  # outgoing rules
  egress = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  # SSH access
  ingress = {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  # ELB access 
  ingress = {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "${ aws_subnet.elbpublic-a.cidr_block }","${ aws_subnet.elbpublic-b.cidr_block }","${ aws_subnet.elbpublic-c.cidr_block }"  ]
  }
  name = "${ var.env }-wordpress-inbound"
  tags {
    Name = "${ var.env }-wordpress-inbound"
    terraform_id = "${ var.env }-terraform"
  }
  vpc_id = "${  aws_vpc.main.id }"
}

# Wordpress ELB security group
resource "aws_security_group" "wordpress-elb" {
  description = "${ var.env } Wordpress ELB security group"
  # outgoing rules
  egress = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  # allow all inbound port 80
  ingress = {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  name = "${ var.env }-wordpress-elb-inbound"
  tags {
    Name = "${ var.env }-wordpress-elb-inbound"
    terraform_id = "${ var.env }-terraform"
  }
  vpc_id = "${  aws_vpc.main.id }"
}

# Wordpress RDS security group
resource "aws_security_group" "wordpress-rds" {
  description = "${ var.env } Wordpress RDS security group"
  # outgoing rules
  egress = {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  # Wordpress instance access
  ingress = {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [ "${ aws_subnet.wordpress-a.cidr_block }","${ aws_subnet.wordpress-b.cidr_block }","${ aws_subnet.wordpress-c.cidr_block }"  ]
  }
  name = "${ var.env }-wordpress-rds-inbound"
  tags {
    Name = "${ var.env }-wordpress-rds-inbound"
    terraform_id = "${ var.env }-terraform"
  }
  vpc_id = "${  aws_vpc.main.id }"
}

