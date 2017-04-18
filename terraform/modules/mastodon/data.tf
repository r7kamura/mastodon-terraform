data "template_file" "mastodon_environment_variables_streaming" {
  template = <<-JSON
  [
    {
      "name": "DB_HOST",
      "value": "${var.mastodon_db_host}",
    },
    {
      "name": "DB_NAME",
      "value": "${var.mastodon_db_name}",
    },
    {
      "name": "DB_PASS",
      "value": "${var.mastodon_db_pass}",
    },
    {
      "name": "DB_PORT",
      "value": "${var.mastodon_db_port}",
    },
    {
      "name": "DB_USER",
      "value": "${var.mastodon_db_user}",
    },
    {
      "name": "LOG_LEVEL",
      "value": "${var.mastodon_streaming_log_level}",
    },
    {
      "name": "NODE_ENV",
      "value": "${var.mastodon_node_env}",
    },
    {
      "name": "PORT",
      "value": "${var.mastodon_streaming_port}",
    },
    {
      "name": "REDIS_HOST",
      "value": "${var.mastodon_redis_host}",
    },
    {
      "name": "REDIS_PASSWORD",
      "value": "${var.mastodon_redis_password}",
    },
    {
      "name": "REDIS_PORT",
      "value": "${var.mastodon_redis_port}",
    }
  ]
  JSON

  vars {
    mastodon_db_host             = "${var.mastodon_db_host}"
    mastodon_db_name             = "${var.mastodon_db_name}"
    mastodon_db_pass             = "${var.mastodon_db_pass}"
    mastodon_db_port             = "${var.mastodon_db_port}"
    mastodon_db_user             = "${var.mastodon_db_user}"
    mastodon_streaming_log_level = "${var.mastodon_streaming_log_level}"
    mastodon_node_env            = "${var.mastodon_node_env}"
    mastodon_redis_host          = "${var.mastodon_redis_host}"
    mastodon_redis_password      = "${var.mastodon_redis_password}"
    mastodon_redis_port          = "${var.mastodon_redis_port}"
    mastodon_streaming_port      = "${var.mastodon_streaming_port}"
  }
}

data "template_file" "mastodon_environment_variables_rails" {
  template = <<-JSON
  [
    {
      "name": "AWS_ACCESS_KEY_ID",
      "value": "${var.mastodon_aws_access_key_id}",
    },
    {
      "name": "AWS_SECRET_ACCESS_KEY",
      "value": "${var.mastodon_aws_secret_access_key}",
    },
    {
      "name": "CDN_HOST",
      "value": "${var.mastodon_cdn_host}",
    },
    {
      "name": "DB_HOST",
      "value": "${var.mastodon_db_host}",
    },
    {
      "name": "DB_NAME",
      "value": "${var.mastodon_db_name}",
    },
    {
      "name": "DB_PASS",
      "value": "${var.mastodon_db_pass}",
    },
    {
      "name": "DB_PORT",
      "value": "${var.mastodon_db_port}",
    },
    {
      "name": "DB_USER",
      "value": "${var.mastodon_db_user}",
    },
    {
      "name": "DEFAULT_LOCALE",
      "value": "${var.mastodon_default_locale}",
    },
    {
      "name": "EMAIL_DOMAIN_BLACKLIST",
      "value": "${var.mastodon_email_domain_blacklist}",
    },
    {
      "name": "EMAIL_DOMAIN_WHITELIST",
      "value": "${var.mastodon_email_domain_whitelist}",
    },
    {
      "name": "LOCAL_DOMAIN",
      "value": "${var.mastodon_local_domain}",
    },
    {
      "name": "LOCAL_HTTPS",
      "value": "${var.mastodon_local_https}",
    },
    {
      "name": "OTP_SECRET",
      "value": "${var.mastodon_otp_secret}",
    },
    {
      "name": "PAPERCLIP_ROOT_PATH",
      "value": "${var.mastodon_paperclip_root_path}",
    },
    {
      "name": "PAPERCLIP_ROOT_URL",
      "value": "${var.mastodon_paperclip_root_url}",
    },
    {
      "name": "PAPERCLIP_SECRET",
      "value": "${var.mastodon_paperclip_secret}",
    },
    {
      "name": "PREPARED_STATEMENTS",
      "value": "${var.mastodon_prepared_statements}",
    },
    {
      "name": "REDIS_HOST",
      "value": "${var.mastodon_redis_host}",
    },
    {
      "name": "REDIS_PASSWORD",
      "value": "${var.mastodon_redis_password}",
    },
    {
      "name": "REDIS_PORT",
      "value": "${var.mastodon_redis_port}",
    },
    {
      "name": "S3_BUCKET",
      "value": "${var.mastodon_s3_bucket}",
    },
    {
      "name": "S3_CLOUDFRONT_HOST",
      "value": "${var.mastodon_s3_cloudfront_host}",
    },
    {
      "name": "S3_ENABLED",
      "value": "${var.mastodon_s3_enabled}",
    },
    {
      "name": "S3_ENDPOINT",
      "value": "${var.mastodon_s3_endpoint}",
    },
    {
      "name": "S3_HOSTNAME",
      "value": "${var.mastodon_s3_hostname}",
    },
    {
      "name": "S3_HOSTNAME",
      "value": "${var.mastodon_s3_hostname}",
    },
    {
      "name": "S3_PROTOCOL",
      "value": "${var.mastodon_s3_protocol}",
    },
    {
      "name": "S3_REGION",
      "value": "${var.mastodon_s3_region}",
    },
    {
      "name": "SECRET_KEY_BASE",
      "value": "${var.mastodon_secret_key_base}",
    },
    {
      "name": "SINGLE_USER_MODE",
      "value": "${var.mastodon_single_user_mode}",
    },
    {
      "name": "SMTP_AUTH_METHOD",
      "value": "${var.mastodon_smtp_auth_method}",
    },
    {
      "name": "SMTP_DELIVERY_METHOD",
      "value": "${var.mastodon_smtp_delivery_method}",
    },
    {
      "name": "SMTP_DOMAIN",
      "value": "${var.mastodon_smtp_domain}",
    },
    {
      "name": "SMTP_ENABLE_STARTTLS_AUTO",
      "value": "${var.mastodon_smtp_enable_starttls_auto}",
    },
    {
      "name": "SMTP_FROM_ADDRESS",
      "value": "${var.mastodon_smtp_from_address}",
    },
    {
      "name": "SMTP_LOGIN",
      "value": "${var.mastodon_smtp_login}",
    },
    {
      "name": "SMTP_OPENSSL_VERIFY_MODE",
      "value": "${var.mastodon_smtp_openssl_verify_mode}",
    },
    {
      "name": "SMTP_PASSWORD",
      "value": "${var.mastodon_smtp_password}",
    },
    {
      "name": "SMTP_PORT",
      "value": "${var.mastodon_smtp_port}",
    },
    {
      "name": "SMTP_SERVER",
      "value": "${var.mastodon_smtp_server}",
    },
    {
      "name": "STREAMING_API_BASE_URL",
      "value": "${var.mastodon_streaming_api_base_url}",
    },
    {
      "name": "STREAMING_CLUSTER_NUM",
      "value": "${var.mastodon_streaming_cluster_num}",
    },
  ]
  JSON

  vars {
    mastodon_aws_access_key_id         = "${var.mastodon_aws_access_key_id}"
    mastodon_aws_secret_access_key     = "${var.mastodon_aws_secret_access_key}"
    mastodon_cdn_host                  = "${var.mastodon_cdn_host}"
    mastodon_db_host                   = "${var.mastodon_db_host}"
    mastodon_db_name                   = "${var.mastodon_db_name}"
    mastodon_db_pass                   = "${var.mastodon_db_pass}"
    mastodon_db_port                   = "${var.mastodon_db_port}"
    mastodon_db_user                   = "${var.mastodon_db_user}"
    mastodon_default_locale            = "${var.mastodon_default_locale}"
    mastodon_email_domain_blacklist    = "${var.mastodon_email_domain_blacklist}"
    mastodon_email_domain_whitelist    = "${var.mastodon_email_domain_whitelist}"
    mastodon_local_domain              = "${var.mastodon_local_domain}"
    mastodon_local_https               = "${var.mastodon_local_https}"
    mastodon_otp_secret                = "${var.mastodon_otp_secret}"
    mastodon_paperclip_root_path       = "${var.mastodon_paperclip_root_path}"
    mastodon_paperclip_root_url        = "${var.mastodon_paperclip_root_url}"
    mastodon_paperclip_secret          = "${var.mastodon_paperclip_secret}"
    mastodon_prepared_statements       = "${var.mastodon_prepared_statements}"
    mastodon_redis_host                = "${var.mastodon_redis_host}"
    mastodon_redis_port                = "${var.mastodon_redis_port}"
    mastodon_s3_bucket                 = "${var.mastodon_s3_bucket}"
    mastodon_s3_cloudfront_host        = "${var.mastodon_s3_cloudfront_host}"
    mastodon_s3_enabled                = "${var.mastodon_s3_enabled}"
    mastodon_s3_endpoint               = "${var.mastodon_s3_endpoint}"
    mastodon_s3_hostname               = "${var.mastodon_s3_hostname}"
    mastodon_s3_hostname               = "${var.mastodon_s3_hostname}"
    mastodon_s3_protocol               = "${var.mastodon_s3_protocol}"
    mastodon_s3_region                 = "${var.mastodon_s3_region}"
    mastodon_secret_key_base           = "${var.mastodon_secret_key_base}"
    mastodon_single_user_mode          = "${var.mastodon_single_user_mode}"
    mastodon_smtp_auth_method          = "${var.mastodon_smtp_auth_method}"
    mastodon_smtp_delivery_method      = "${var.mastodon_smtp_delivery_method}"
    mastodon_smtp_domain               = "${var.mastodon_smtp_domain}"
    mastodon_smtp_enable_starttls_auto = "${var.mastodon_smtp_enable_starttls_auto}"
    mastodon_smtp_from_address         = "${var.mastodon_smtp_from_address}"
    mastodon_smtp_login                = "${var.mastodon_smtp_login}"
    mastodon_smtp_openssl_verify_mode  = "${var.mastodon_smtp_openssl_verify_mode}"
    mastodon_smtp_password             = "${var.mastodon_smtp_password}"
    mastodon_smtp_port                 = "${var.mastodon_smtp_port}"
    mastodon_smtp_server               = "${var.mastodon_smtp_server}"
    mastodon_streaming_api_base_url    = "${var.mastodon_streaming_api_base_url}"
    mastodon_streaming_cluster_num     = "${var.mastodon_streaming_cluster_num}"
  }
}
