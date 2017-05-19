output "aws_cloudfront_distribution_mastodon_domain_name" {
  value = "${aws_cloudfront_distribution.mastodon.domain_name}"
}

output "aws_cloudfront_distribution_mastodon_file_domain_name" {
  value = "${aws_cloudfront_distribution.mastodon_file.domain_name}"
}

output "aws_cloudfront_distribution_mastodon_file_hosted_zone_id" {
  value = "${aws_cloudfront_distribution.mastodon_file.hosted_zone_id}"
}

output "aws_cloudfront_distribution_mastodon_hosted_zone_id" {
  value = "${aws_cloudfront_distribution.mastodon.hosted_zone_id}"
}

output "aws_alb_mastodon_dns_name" {
  value = "${aws_alb.mastodon.dns_name}"
}

output "aws_alb_mastodon_zone_id" {
  value = "${aws_alb.mastodon.zone_id}"
}
