data "aws_region" "current" {
  current = true
}

data "template_file" "mastodon_environment_variables_rails" {
  template = <<-JSON
  [
    {
      "name": "AWS_ACCESS_KEY_ID",
      "value": "$${mastodon_aws_access_key_id}"
    },
    {
      "name": "AWS_SECRET_ACCESS_KEY",
      "value": "$${mastodon_aws_secret_access_key}"
    },
    {
      "name": "DB_HOST",
      "value": "$${mastodon_db_host}"
    },
    {
      "name": "DB_NAME",
      "value": "$${mastodon_db_name}"
    },
    {
      "name": "DB_PASS",
      "value": "$${mastodon_db_pass}"
    },
    {
      "name": "DB_PORT",
      "value": "$${mastodon_db_port}"
    },
    {
      "name": "DB_USER",
      "value": "$${mastodon_db_user}"
    },
    {
      "name": "DEFAULT_LOCALE",
      "value": "$${mastodon_default_locale}"
    },
    {
      "name": "EMAIL_DOMAIN_BLACKLIST",
      "value": "$${mastodon_email_domain_blacklist}"
    },
    {
      "name": "EMAIL_DOMAIN_WHITELIST",
      "value": "$${mastodon_email_domain_whitelist}"
    },
    {
      "name": "LOCAL_DOMAIN",
      "value": "$${mastodon_local_domain}"
    },
    {
      "name": "LOCAL_HTTPS",
      "value": "$${mastodon_local_https}"
    },
    {
      "name": "OTP_SECRET",
      "value": "$${mastodon_otp_secret}"
    },
    {
      "name": "PAPERCLIP_ROOT_PATH",
      "value": "$${mastodon_paperclip_root_path}"
    },
    {
      "name": "PAPERCLIP_ROOT_URL",
      "value": "$${mastodon_paperclip_root_url}"
    },
    {
      "name": "PAPERCLIP_SECRET",
      "value": "$${mastodon_paperclip_secret}"
    },
    {
      "name": "PREPARED_STATEMENTS",
      "value": "$${mastodon_prepared_statements}"
    },
    {
      "name": "REDIS_HOST",
      "value": "$${mastodon_redis_host}"
    },
    {
      "name": "REDIS_PORT",
      "value": "$${mastodon_redis_port}"
    },
    {
      "name": "S3_BUCKET",
      "value": "$${mastodon_s3_bucket}"
    },
    {
      "name": "S3_CLOUDFRONT_HOST",
      "value": "$${mastodon_s3_cloudfront_host}"
    },
    {
      "name": "S3_ENABLED",
      "value": "true"
    },
    {
      "name": "S3_REGION",
      "value": "$${mastodon_s3_region}"
    },
    {
      "name": "SECRET_KEY_BASE",
      "value": "$${mastodon_secret_key_base}"
    },
    {
      "name": "SINGLE_USER_MODE",
      "value": "$${mastodon_single_user_mode}"
    },
    {
      "name": "SMTP_AUTH_METHOD",
      "value": "$${mastodon_smtp_auth_method}"
    },
    {
      "name": "SMTP_DELIVERY_METHOD",
      "value": "$${mastodon_smtp_delivery_method}"
    },
    {
      "name": "SMTP_DOMAIN",
      "value": "$${mastodon_smtp_domain}"
    },
    {
      "name": "SMTP_ENABLE_STARTTLS_AUTO",
      "value": "$${mastodon_smtp_enable_starttls_auto}"
    },
    {
      "name": "SMTP_FROM_ADDRESS",
      "value": "$${mastodon_smtp_from_address}"
    },
    {
      "name": "SMTP_LOGIN",
      "value": "$${mastodon_smtp_login}"
    },
    {
      "name": "SMTP_OPENSSL_VERIFY_MODE",
      "value": "$${mastodon_smtp_openssl_verify_mode}"
    },
    {
      "name": "SMTP_PASSWORD",
      "value": "$${mastodon_smtp_password}"
    },
    {
      "name": "SMTP_PORT",
      "value": "$${mastodon_smtp_port}"
    },
    {
      "name": "SMTP_SERVER",
      "value": "$${mastodon_smtp_server}"
    },
    {
      "name": "STREAMING_API_BASE_URL",
      "value": "$${mastodon_node_streaming_api_base_url}"
    },
    {
      "name": "STREAMING_CLUSTER_NUM",
      "value": "$${mastodon_node_streaming_cluster_num}"
    }
  ]
  JSON

  vars {
    mastodon_aws_access_key_id           = "${var.mastodon_aws_access_key_id}"
    mastodon_aws_secret_access_key       = "${var.mastodon_aws_secret_access_key}"
    mastodon_db_host                     = "${aws_db_instance.mastodon.address}"
    mastodon_db_name                     = "${aws_db_instance.mastodon.name}"
    mastodon_db_pass                     = "${var.mastodon_db_pass}"
    mastodon_db_port                     = "${aws_db_instance.mastodon.port}"
    mastodon_db_user                     = "${aws_db_instance.mastodon.username}"
    mastodon_default_locale              = "${var.mastodon_default_locale}"
    mastodon_email_domain_blacklist      = "${var.mastodon_email_domain_blacklist}"
    mastodon_email_domain_whitelist      = "${var.mastodon_email_domain_whitelist}"
    mastodon_local_domain                = "${var.mastodon_local_domain}"
    mastodon_local_https                 = "${var.aws_acm_certificate_arn == "" ? "false" : "true"}"
    mastodon_otp_secret                  = "${var.mastodon_otp_secret}"
    mastodon_paperclip_root_path         = "${var.mastodon_paperclip_root_path}"
    mastodon_paperclip_root_url          = "${var.mastodon_paperclip_root_url}"
    mastodon_paperclip_secret            = "${var.mastodon_paperclip_secret}"
    mastodon_prepared_statements         = "${var.mastodon_prepared_statements}"
    mastodon_redis_host                  = "${aws_elasticache_cluster.mastodon.cache_nodes.0.address}"
    mastodon_redis_port                  = "${aws_elasticache_cluster.mastodon.cache_nodes.0.port}"
    mastodon_s3_bucket                   = "${var.aws_s3_bucket_name}"
    mastodon_s3_cloudfront_host          = "${var.mastodon_s3_cloudfront_host}"
    mastodon_s3_region                   = "${data.aws_region.current.name}"
    mastodon_secret_key_base             = "${var.mastodon_secret_key_base}"
    mastodon_single_user_mode            = "${var.mastodon_single_user_mode}"
    mastodon_smtp_auth_method            = "${var.mastodon_smtp_auth_method}"
    mastodon_smtp_delivery_method        = "${var.mastodon_smtp_delivery_method}"
    mastodon_smtp_domain                 = "${var.mastodon_smtp_domain}"
    mastodon_smtp_enable_starttls_auto   = "${var.mastodon_smtp_enable_starttls_auto}"
    mastodon_smtp_from_address           = "${var.mastodon_smtp_from_address}"
    mastodon_smtp_login                  = "${var.mastodon_smtp_login}"
    mastodon_smtp_openssl_verify_mode    = "${var.mastodon_smtp_openssl_verify_mode}"
    mastodon_smtp_password               = "${var.mastodon_smtp_password}"
    mastodon_smtp_port                   = "${var.mastodon_smtp_port}"
    mastodon_smtp_server                 = "${var.mastodon_smtp_server}"
    mastodon_node_streaming_api_base_url = "${var.mastodon_node_streaming_api_base_url}"
    mastodon_node_streaming_cluster_num  = "${var.mastodon_node_streaming_cluster_num}"
  }
}

data "template_file" "mastodon_environment_variables_streaming" {
  template = <<-JSON
  [
    {
      "name": "DB_HOST",
      "value": "$${mastodon_db_host}"
    },
    {
      "name": "DB_NAME",
      "value": "$${mastodon_db_name}"
    },
    {
      "name": "DB_PASS",
      "value": "$${mastodon_db_pass}"
    },
    {
      "name": "DB_PORT",
      "value": "$${mastodon_db_port}"
    },
    {
      "name": "DB_USER",
      "value": "$${mastodon_db_user}"
    },
    {
      "name": "NODE_ENV",
      "value": "production"
    },
    {
      "name": "REDIS_HOST",
      "value": "$${mastodon_redis_host}"
    },
    {
      "name": "REDIS_PORT",
      "value": "$${mastodon_redis_port}"
    }
  ]
  JSON

  vars = {
    mastodon_db_host             = "${aws_db_instance.mastodon.address}"
    mastodon_db_name             = "${aws_db_instance.mastodon.name}"
    mastodon_db_pass             = "${var.mastodon_db_pass}"
    mastodon_db_port             = "${aws_db_instance.mastodon.port}"
    mastodon_db_user             = "${aws_db_instance.mastodon.username}"
    mastodon_node_streaming_port = "${var.mastodon_node_streaming_port}"
    mastodon_redis_host          = "${aws_elasticache_cluster.mastodon.cache_nodes.0.address}"
    mastodon_redis_port          = "${aws_elasticache_cluster.mastodon.cache_nodes.0.port}"
  }
}
