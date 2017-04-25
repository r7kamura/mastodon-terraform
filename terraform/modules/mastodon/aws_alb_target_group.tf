resource "aws_alb_target_group" "mastodon_node_streaming" {
  name                 = "mastodon-node-streaming"
  port                 = 4000
  protocol             = "HTTP"
  vpc_id               = "${aws_vpc.mastodon.id}"
  deregistration_delay = 10

  health_check {
    healthy_threshold   = 1
    interval            = 60
    matcher             = "401"
    path                = "/"
    timeout             = 10
    unhealthy_threshold = 5
  }

  stickiness {
    type = "lb_cookie"
  }
}

resource "aws_alb_target_group" "mastodon_rails_puma" {
  name                 = "mastodon-rails-puma"
  port                 = 80
  protocol             = "HTTP"
  vpc_id               = "${aws_vpc.mastodon.id}"
  deregistration_delay = 10

  health_check {
    healthy_threshold   = 1
    interval            = 60
    matcher             = "200"
    path                = "/about"
    timeout             = 10
    unhealthy_threshold = 5
  }

  stickiness {
    type = "lb_cookie"
  }
}
