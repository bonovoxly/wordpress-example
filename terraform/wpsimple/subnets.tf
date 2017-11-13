# ELB public subnet a
resource "aws_subnet" "elbpublic-a" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.1.0/24"
  availability_zone = "${ var.region }a"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-elbpublic-subnet-a"
    Environment  = "${ var.env }"
    Role         = "elb"
    Zone         = "public"
  }
}

# ELB public subnet b
resource "aws_subnet" "elbpublic-b" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.2.0/24"
  availability_zone = "${ var.region }b"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-elbpublic-subnet-b"
    Environment  = "${ var.env }"
    Role         = "elb"
    Zone         = "public"
  }
}

# ELB public subnet c
resource "aws_subnet" "elbpublic-c" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.3.0/24"
  availability_zone = "${ var.region }c"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-elbpublic-subnet-c"
    Environment  = "${ var.env }"
    Role         = "elb"
    Zone         = "public"
  }
}

# wordpress subnet a
resource "aws_subnet" "wordpress-a" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.4.0/24"
  availability_zone = "${ var.region }a"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-wordpress-subnet-a"
    Environment  = "${ var.env }"
    Role         = "wordpress"
    Zone         = "public"
  }
}

# wordpress subnet b
resource "aws_subnet" "wordpress-b" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.5.0/24"
  availability_zone = "${ var.region }b"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-wordpress-subnet-b"
    Environment  = "${ var.env }"
    Role         = "wordpress"
    Zone         = "public"
  }
}

# wordpress subnet c
resource "aws_subnet" "wordpress-c" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.6.0/24"
  availability_zone = "${ var.region }c"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-wordpress-subnet-c"
    Environment  = "${ var.env }"
    Role         = "wordpress"
    Zone         = "public"
  }
}

# DB subnet a
resource "aws_subnet" "db-a" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.41.0/24"
  availability_zone = "${ var.region }a"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-db-subnet-a"
    Environment  = "${ var.env }"
    Role         = "DB"
    Zone         = "private"
  }
}

# DB subnet b
resource "aws_subnet" "db-b" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.42.0/24"
  availability_zone = "${ var.region }b"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-db-subnet-b"
    Environment  = "${ var.env }"
    Zone         = "private"
  }
}

# DB subnet c
resource "aws_subnet" "db-c" {
  vpc_id            ="${ aws_vpc.main.id }"
  cidr_block        = "${ var.cidr }.43.0/24"
  availability_zone = "${ var.region }c"

  tags {
    terraform_id = "${ var.env }-terraform"
    Name         = "${ var.env }-db-subnet-c"
    Environment  = "${ var.env }"
    Zone         = "private"
  }
}
