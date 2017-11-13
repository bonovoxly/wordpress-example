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
  # access from the VPN server
  ingress = {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [ "${ data.aws_instance.vpn.private_ip }/32" ]
  }
  # Pod access
  ingress = {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = [ "${ data.aws_subnet.node-a.cidr_block }","${ data.aws_subnet.node-b.cidr_block }","${ data.aws_subnet.node-c.cidr_block }"  ]
  }
  name = "${ var.env }-wordpress-rds-inbound"
  tags {
    Name = "${ var.env }-wordpress-rds-inbound"
    terraform_id = "${ var.env }-terraform"
  }
  vpc_id = "${  data.aws_vpc.vpc.id }"
}

