resource "aws_internet_gateway" "mastodon" {
  vpc_id = "${aws_vpc.mastodon.id}"

  tags {
    Name = "mastodon"
  }
}
