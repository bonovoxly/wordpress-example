# public route
resource "aws_route_table" "public" {
  vpc_id = "${ aws_vpc.main.id }"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${ aws_internet_gateway.main.id }"
  }
  tags {
    Name         = "${ var.env }-public-route"
    terraform_id = "${ var.env }-terraform"
  }
}

# elbpublic-a association
resource "aws_route_table_association" "elbpublic-a" {
  subnet_id      = "${ aws_subnet.elbpublic-a.id }"
  route_table_id = "${ aws_route_table.public.id }"
}

# elbpublic-b association
resource "aws_route_table_association" "elbpublic-b" {
  subnet_id      = "${ aws_subnet.elbpublic-b.id }"
  route_table_id = "${ aws_route_table.public.id }"
}

# elbpublic-c association
resource "aws_route_table_association" "elbpublic-c" {
  subnet_id      = "${ aws_subnet.elbpublic-c.id }"
  route_table_id = "${ aws_route_table.public.id }"
}

# wordpress-a association
resource "aws_route_table_association" "wordpress-a" {
  subnet_id      = "${ aws_subnet.wordpress-a.id }"
  route_table_id = "${ aws_route_table.public.id }"
}

# wordpress-b association
resource "aws_route_table_association" "wordpress-b" {
  subnet_id      = "${ aws_subnet.wordpress-b.id }"
  route_table_id = "${ aws_route_table.public.id }"
}

# wordpress-c association
resource "aws_route_table_association" "wordpress-c" {
  subnet_id      = "${ aws_subnet.wordpress-c.id }"
  route_table_id = "${ aws_route_table.public.id }"
}

