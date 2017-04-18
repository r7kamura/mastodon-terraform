resource "aws_route_table_association" "mastodon_a" {
  route_table_id = "${aws_route_table.mastodon.id}"
  subnet_id      = "${aws_subnet.mastodon_public_a.id}"
}

resource "aws_route_table_association" "mastodon_c" {
  route_table_id = "${aws_route_table.mastodon.id}"
  subnet_id      = "${aws_subnet.mastodon_public_c.id}"
}
