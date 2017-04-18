resource "aws_subnet" "mastodon_public_a" {
  availability_zone = "${var.aws_region}a"
  cidr_block        = "10.0.1.0/24"
  vpc_id            = "${aws_vpc.mastodon.id}"
}

resource "aws_subnet" "mastodon_public_c" {
  availability_zone = "${var.aws_region}c"
  cidr_block        = "10.0.2.0/24"
  vpc_id            = "${aws_vpc.mastodon.id}"
}

resource "aws_subnet" "mastodon_private_a" {
  availability_zone = "${var.aws_region}a"
  cidr_block        = "10.0.128.0/24"
  vpc_id            = "${aws_vpc.mastodon.id}"
}

resource "aws_subnet" "mastodon_private_c" {
  availability_zone = "${var.aws_region}c"
  cidr_block        = "10.0.129.0/24"
  vpc_id            = "${aws_vpc.mastodon.id}"
}
