resource "aws_s3_bucket_policy" "mastodon" {
  bucket = "${var.aws_s3_bucket_name}"

  policy = <<-JSON
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Action": "s3:GetObject",
        "Effect": "Allow",
        "Principal": {
          "AWS": "*"
        },
        "Resource": "arn:aws:s3:::${var.aws_s3_bucket_name}/*"
      }
    ]
  }
  JSON
}
