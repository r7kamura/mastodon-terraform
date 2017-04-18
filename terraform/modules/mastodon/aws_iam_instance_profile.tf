resource "aws_iam_instance_profile" "mastodon" {
  name  = "mastodon"
  role = "${aws_iam_role.mastodon_ec2.name}"
}
