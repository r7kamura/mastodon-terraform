resource "aws_db_parameter_group" "mastodon" {
  name   = "${var.aws_resource_base_name}"
  family = "postgres9.6"
}
