resource "aws_ecs_cluster" "mastodon" {
  name = "${var.aws_resource_base_name}"
}
