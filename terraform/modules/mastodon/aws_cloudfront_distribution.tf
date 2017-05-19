resource "aws_cloudfront_distribution" "mastodon" {
  aliases = ["${var.mastodon_local_domain}"]
  comment = "mastodon"
  enabled = true

  cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    default_ttl            = 3600
    max_ttl                = 86400
    min_ttl                = 0
    viewer_protocol_policy = "allow-all"
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
    viewer_protocol_policy = "${var.aws_acm_certificate_arn == "" ? "allow-all" : "redirect-to-https"}"
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

    custom_header {
      name  = "X-Forwarded-Scheme"
      value = "${var.aws_acm_certificate_arn == "" ? "http" : "https"}"
    }

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
    cloudfront_default_certificate = "${var.aws_acm_certificate_arn == "" ? "1" : "0"}"
    minimum_protocol_version       = "TLSv1"
    ssl_support_method             = "sni-only"
  }
}

resource "aws_cloudfront_distribution" "mastodon_file" {
  aliases = ["${var.mastodon_s3_cloudfront_host}"]
  comment = "${var.aws_resource_base_name}"
  enabled = true

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    default_ttl     = 86400

    forwarded_values {
      cookies {
        forward = "none"
      }

      headers = ["Origin"]

      query_string = false
    }

    max_ttl                = 86400
    min_ttl                = 0
    target_origin_id       = "mastodon_s3"
    viewer_protocol_policy = "${var.aws_acm_certificate_arn == "" ? "allow-all" : "redirect-to-https"}"
  }

  origin {
    domain_name = "${aws_s3_bucket.mastodon.bucket_domain_name}"
    origin_id   = "mastodon_s3"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = "${var.aws_acm_certificate_arn}"
    cloudfront_default_certificate = "${var.aws_acm_certificate_arn == "" ? "1" : "0"}"
    minimum_protocol_version       = "TLSv1"
    ssl_support_method             = "sni-only"
  }
}
