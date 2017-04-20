resource "aws_iam_instance_profile" "mastodon" {
  name  = "mastodon"
  roles = ["${aws_iam_role.mastodon_ec2.name}"]
}
