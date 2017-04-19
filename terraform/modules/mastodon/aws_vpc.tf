resource "aws_vpc" "mastodon" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "mastodon"
  }
}
