resource "aws_alb" "mastodon" {
  name = "mastodon"

  subnets = [
    "${aws_subnet.mastodon_public_a.id}",
    "${aws_subnet.mastodon_public_c.id}",
  ]

  security_groups = [
    "${aws_security_group.mastodon_alb.id}",
  ]
}
