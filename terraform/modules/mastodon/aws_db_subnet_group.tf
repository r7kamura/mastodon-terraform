resource "aws_db_subnet_group" "mastodon" {
  name        = "mastodon"
  description = "mastodon"

  subnet_ids = [
    "${aws_subnet.mastodon_private_a.id}",
    "${aws_subnet.mastodon_private_c.id}",
  ]
}
