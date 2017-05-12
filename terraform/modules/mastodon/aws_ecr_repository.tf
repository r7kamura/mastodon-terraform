resource "aws_ecr_repository" "mastodon" {
  name = "${var.aws_resource_base_name}"
}
