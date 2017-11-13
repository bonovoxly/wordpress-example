# wordpress instance profile
resource "aws_iam_instance_profile" "wordpress" {
  name = "${ var.env }-wordpress-profile"
  role = "${ aws_iam_role.wordpress.name }"
}


# wordpress IAM role
resource "aws_iam_role" "wordpress" {
  name               = "${ var.env }-wordpress-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

