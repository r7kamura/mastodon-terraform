resource "aws_db_parameter_group" "mastodon" {
  name   = "mastodon"
  family = "postgres9.6"
}
