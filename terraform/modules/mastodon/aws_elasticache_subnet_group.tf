resource "aws_elasticache_subnet_group" "mastodon" {
  name = "${var.aws_resource_base_name}"

  subnet_ids = [
    "${aws_subnet.mastodon_private_a.id}",
    "${aws_subnet.mastodon_private_c.id}",
  ]
}
