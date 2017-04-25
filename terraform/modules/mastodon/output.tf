output "aws_cloudfront_distribution_mastodon_domain_name" {
  value = "${aws_cloudfront_distribution.mastodon.domain_name}"
}

output "aws_cloudfront_distribution_mastodon_hosted_zone_id" {
  value = "${aws_cloudfront_distribution.mastodon.hosted_zone_id}"
}
