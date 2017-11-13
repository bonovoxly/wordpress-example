# Wordpress RDS subnet group
resource "aws_db_subnet_group" "wordpress-rds" {
  name = "${ var.env }-wordpress-rds-subnet-group"
  subnet_ids = ["${ data.aws_subnet.db-a.id }", "${ data.aws_subnet.db-b.id }", "${ data.aws_subnet.db-c.id }"]
  tags {
    Name = "${ var.env }-wordpress-subnet-group"
    terraform_id = "${ var.env }-terraform"
    Environment = "${ var.env }"
    Role = "wordpress-subnet-group"
  }
}

# Wordpress RDS
resource "aws_db_instance" "wordpress" {  
  allocated_storage = 5
  backup_retention_period = 7
  db_subnet_group_name = "${ aws_db_subnet_group.wordpress-rds.name }"
  engine = "mysql"
  engine_version = "5.7.19"
  final_snapshot_identifier = "${ var.env }-wordpress-final-snapshot"
  identifier = "wordpress"
  instance_class = "db.t2.micro" # note this instance class does not support encryption at rest (would normally encrypt RDS data)
  multi_az = false
  name = "wordpress"
  password = "${ var.rds_password }"
  storage_encrypted = false # see "instance_class"
  storage_type = "gp2"
  username = "admin"
  vpc_security_group_ids = ["${ aws_security_group.wordpress-rds.id }"]
}
