resource "aws_iam_role_policy" "mastodon_rails" {
  name = "${var.aws_resource_base_name}_rails"

  policy = <<-JSON
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "s3:DeleteObject",
          "s3:PutObject",
          "s3:PutObjectAcl"
        ],
        "Effect": "Allow",
        "Resource": [
          "arn:aws:s3:::${var.aws_s3_bucket_name}/*"
        ]
      }
    ]
  }
  JSON

  role = "${aws_iam_role.mastodon_rails.id}"
}
