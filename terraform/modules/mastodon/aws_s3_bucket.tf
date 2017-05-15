resource "aws_s3_bucket" "mastodon" {
  bucket = "${var.aws_s3_bucket_name}"

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET", "HEAD"]
    allowed_origins = ["*"]
    max_age_seconds = "3000"
  }
}
