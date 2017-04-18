resource "aws_alb_listener" "mastodon" {
  load_balancer_arn = "${aws_alb.mastodon.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.mastodon.id}"
    type             = "forward"
  }
}
