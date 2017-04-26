resource "aws_alb_listener" "mastodon_node_streaming" {
  certificate_arn   = "${var.aws_acm_certificate_arn_for_alb}"
  load_balancer_arn = "${aws_alb.mastodon.arn}"
  port              = "${var.mastodon_node_streaming_port}"
  protocol          = "${var.aws_acm_certificate_arn_for_alb == "" ? "HTTP" : "HTTPS"}"

  default_action {
    target_group_arn = "${aws_alb_target_group.mastodon_node_streaming.id}"
    type             = "forward"
  }
}

resource "aws_alb_listener" "mastodon_rails_puma" {
  load_balancer_arn = "${aws_alb.mastodon.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.mastodon_rails_puma.id}"
    type             = "forward"
  }
}
