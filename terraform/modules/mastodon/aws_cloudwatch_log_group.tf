resource "aws_cloudwatch_log_group" "mastodon" {
  name = "${var.aws_resource_base_name}"
}
