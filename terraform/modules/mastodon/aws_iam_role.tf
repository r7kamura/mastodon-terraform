resource "aws_iam_role" "mastodon_ec2" {
  name = "mastodon_ec2"

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
  name = "mastodon_ecs"

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
