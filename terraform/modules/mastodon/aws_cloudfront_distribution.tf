resource "aws_cloudfront_distribution" "mastodon" {
  comment = "mastodon"
  enabled = true

  aliases = ["${var.mastodon_local_domain}"]

  cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    default_ttl            = 3600
    max_ttl                = 86400
    min_ttl                = 0
    viewer_protocol_policy = "redirect-to-https"
    path_pattern           = "/assets/*"
    compress               = true
    target_origin_id       = "mastodon_alb"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }

      headers = ["CloudFront-Forwarded-Proto", "Origin"]
    }
  }

  custom_error_response {
    error_caching_min_ttl = 0
    error_code            = 404
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD"]
    default_ttl            = 0
    max_ttl                = 0
    min_ttl                = 0
    viewer_protocol_policy = "redirect-to-https"
    target_origin_id       = "mastodon_alb"

    forwarded_values {
      headers      = ["*"]
      query_string = true

      cookies {
        forward = "all"
      }
    }
  }

  origin {
    domain_name = "${aws_alb.mastodon.dns_name}"
    origin_id   = "mastodon_alb"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = "${var.aws_acm_certificate_arn}"
    cloudfront_default_certificate = true
    minimum_protocol_version       = "TLSv1"
    ssl_support_method             = "sni-only"
  }
}
