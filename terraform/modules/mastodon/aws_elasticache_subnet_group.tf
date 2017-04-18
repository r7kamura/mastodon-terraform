resource "aws_elasticache_subnet_group" "mastodon" {
  name = "mastodon"

  subnet_ids = [
    "${aws_subnet.mastodon_private_a.id}",
    "${aws_subnet.mastodon_private_c.id}",
  ]
}
