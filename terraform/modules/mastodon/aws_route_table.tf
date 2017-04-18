resource "aws_route_table" "mastodon" {
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.mastodon.id}"
  }

  vpc_id = "${aws_vpc.mastodon.id}"
}
