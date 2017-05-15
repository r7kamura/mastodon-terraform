resource "aws_iam_role" "mastodon_ec2" {
  name = "${var.aws_resource_base_name}_ec2"

  assume_role_policy = <<-JSON
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
  JSON
}

resource "aws_iam_role" "mastodon_ecs" {
  name = "${var.aws_resource_base_name}_ecs"

  assume_role_policy = <<-JSON
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
  JSON
}

resource "aws_iam_role" "mastodon_rails" {
  name = "${var.aws_resource_base_name}_rails"

  assume_role_policy = <<-JSON
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
  JSON
}
