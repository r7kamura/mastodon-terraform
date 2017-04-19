resource "aws_alb_listener" "mastodon_node_streaming" {
  load_balancer_arn = "${aws_alb.mastodon.arn}"
  port              = "4000"
  protocol          = "HTTP"

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
