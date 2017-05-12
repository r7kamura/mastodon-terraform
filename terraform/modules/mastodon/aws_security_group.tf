resource "aws_security_group" "mastodon_alb" {
  name   = "${var.aws_resource_base_name}_alb"
  vpc_id = "${aws_vpc.mastodon.id}"

  ingress = {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress = {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress = {
    from_port   = "${var.mastodon_node_streaming_port}"
    to_port     = "${var.mastodon_node_streaming_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "mastodon_web" {
  name   = "${var.aws_resource_base_name}_web"
  vpc_id = "${aws_vpc.mastodon.id}"

  ingress = {
    from_port = 0
    to_port   = 65535
    protocol  = "tcp"

    security_groups = [
      "${aws_security_group.mastodon_alb.id}",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "mastodon_db" {
  name   = "${var.aws_resource_base_name}_db"
  vpc_id = "${aws_vpc.mastodon.id}"

  ingress = {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"

    security_groups = [
      "${aws_security_group.mastodon_web.id}",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "mastodon_elasticache" {
  name   = "${var.aws_resource_base_name}_elasticache"
  vpc_id = "${aws_vpc.mastodon.id}"

  ingress = {
    from_port = 6379
    to_port   = 6379
    protocol  = "tcp"

    security_groups = [
      "${aws_security_group.mastodon_web.id}",
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
