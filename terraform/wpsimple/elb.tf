resource "aws_elb" "wordpress" {
  name               = "${ var.env }-wordpress-elb"
  security_groups    = ["${ aws_security_group.wordpress-elb.id}"]
  subnets            = ["${ aws_subnet.elbpublic-a.id  }", "${ aws_subnet.elbpublic-b.id  }", "${ aws_subnet.elbpublic-c.id  }"]
  instances          = ["${ aws_instance.wordpress-a.id }", "${ aws_instance.wordpress-b.id }", "${ aws_instance.wordpress-c.id }" ]

  listener {
    instance_port     = 80
    instance_protocol = "tcp"
    lb_port           = 80
    lb_protocol       = "tcp"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:80"
    interval            = 10
  }

  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 60

  tags {
    Name = "${ var.env }-wordpress-elb"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
  }
}

