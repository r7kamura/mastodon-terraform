resource "aws_autoscaling_group" "mastodon" {
  desired_capacity     = "${var.aws_autoscaling_group_desired_capacity}"
  health_check_type    = "EC2"
  launch_configuration = "${aws_launch_configuration.mastodon.name}"
  max_size             = "${var.aws_autoscaling_group_max_size}"
  min_size             = "${var.aws_autoscaling_group_min_size}"
  name                 = "${var.aws_resource_base_name}"

  vpc_zone_identifier = [
    "${aws_subnet.mastodon_public_a.id}",
    "${aws_subnet.mastodon_public_c.id}",
  ]
}
