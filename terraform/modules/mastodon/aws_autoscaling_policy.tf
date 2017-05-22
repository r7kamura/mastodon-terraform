resource "aws_autoscaling_policy" "mastodon_scale_in" {
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${aws_autoscaling_group.mastodon.name}"
  cooldown               = 300
  name                   = "${var.aws_resource_base_name}-scale-in"
  scaling_adjustment     = -1
}

resource "aws_autoscaling_policy" "mastodon_scale_out" {
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = "${aws_autoscaling_group.mastodon.name}"
  cooldown               = 300
  name                   = "${var.aws_resource_base_name}-scale-out"
  scaling_adjustment     = 1
}
