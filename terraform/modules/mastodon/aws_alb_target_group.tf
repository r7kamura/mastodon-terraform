resource "aws_alb_target_group" "mastodon" {
  name                 = "mastodon"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = "${aws_vpc.mastodon.id}"
  deregistration_delay = 10

  health_check {
    healthy_threshold   = 2
    interval            = 60
    path                = "/"
    timeout             = 10
    unhealthy_threshold = 2
  }

  stickiness {
    type = "lb_cookie"
  }
}
