resource "aws_alb_target_group" "mastodon_node_streaming" {
  deregistration_delay = 10

  health_check {
    healthy_threshold   = 2
    interval            = 60
    matcher             = "401"
    path                = "/"
    timeout             = 10
    unhealthy_threshold = 5
  }

  name     = "${var.aws_resource_base_name}-node-streaming"
  port     = "${var.mastodon_node_streaming_port}"
  protocol = "HTTP"

  stickiness {
    type = "lb_cookie"
  }

  vpc_id = "${aws_vpc.mastodon.id}"
}

resource "aws_alb_target_group" "mastodon_rails_puma" {
  deregistration_delay = 10

  health_check {
    healthy_threshold   = 2
    interval            = 60
    matcher             = "200,301"
    path                = "/about"
    timeout             = 10
    unhealthy_threshold = 5
  }

  name     = "${var.aws_resource_base_name}-rails-puma"
  port     = 80
  protocol = "HTTP"

  stickiness {
    type = "lb_cookie"
  }

  vpc_id = "${aws_vpc.mastodon.id}"
}
