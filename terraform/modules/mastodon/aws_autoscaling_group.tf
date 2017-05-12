resource "aws_autoscaling_group" "mastodon" {
  desired_capacity     = 1
  health_check_type    = "EC2"
  launch_configuration = "${aws_launch_configuration.mastodon.name}"
  max_size             = 1
  min_size             = 1
  name                 = "${var.aws_resource_base_name}"

  vpc_zone_identifier = [
    "${aws_subnet.mastodon_public_a.id}",
    "${aws_subnet.mastodon_public_c.id}",
  ]
}
