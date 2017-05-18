variable "aws_acm_certificate_arn" {}

variable "aws_acm_certificate_arn_for_alb" {}

variable "aws_autoscaling_group_desired_capacity" {}

variable "aws_autoscaling_group_max_size" {}

variable "aws_autoscaling_group_min_size" {}

variable "aws_db_instance_mastodon_instance_class" {}

variable "aws_ecs_optimized_ami_ids" {
  default = {
    "ap-northeast-1" = "ami-f63f6f91"
    "ap-southeast-1" = "ami-b4ae1dd7"
    "ap-southeast-2" = "ami-fbe9eb98"
    "ca-central-1"   = "ami-ee58e58a"
    "eu-central-1"   = "ami-085e8a67"
    "eu-west-1"      = "ami-95f8d2f3"
    "eu-west-2"      = "ami-bf9481db"
    "us-east-1"      = "ami-275ffe31"
    "us-east-2"      = "ami-62745007"
    "us-west-1"      = "ami-689bc208"
    "us-west-2"      = "ami-62d35c02"
  }
}

variable "aws_ecs_service_desired_count_node_streaming" {}

variable "aws_ecs_service_desired_count_rails_puma" {}

variable "aws_ecs_service_desired_count_rails_sidekiq" {}

variable "aws_ecs_task_definition_mastodon_node_streaming_memory" {}

variable "aws_ecs_task_definition_mastodon_rails_db_migration_memory" {}

variable "aws_ecs_task_definition_mastodon_rails_db_set_up_memory" {}

variable "aws_ecs_task_definition_mastodon_rails_mastodon_make_admin_memory" {}

variable "aws_ecs_task_definition_mastodon_rails_puma_memory" {}

variable "aws_ecs_task_definition_mastodon_rails_sidekiq_memory" {}

variable "aws_elasticache_cluster_node_type" {}

variable "aws_launch_configuration_mastodon_instance_type" {}

variable "aws_resource_base_name" {}

variable "aws_s3_bucket_name" {}

variable "mastodon_administrator_name" {}

variable "mastodon_aws_access_key_id" {}

variable "mastodon_aws_secret_access_key" {}

variable "mastodon_db_name" {}

variable "mastodon_db_pass" {}

variable "mastodon_db_user" {}

variable "mastodon_default_locale" {}

variable "mastodon_docker_image_tag" {}

variable "mastodon_email_domain_blacklist" {}

variable "mastodon_email_domain_whitelist" {}

variable "mastodon_local_domain" {}

variable "mastodon_otp_secret" {}

variable "mastodon_paperclip_root_path" {}

variable "mastodon_paperclip_root_url" {}

variable "mastodon_paperclip_secret" {}

variable "mastodon_prepared_statements" {}

variable "mastodon_s3_cloudfront_host" {}

variable "mastodon_secret_key_base" {}

variable "mastodon_single_user_mode" {}

variable "mastodon_smtp_auth_method" {}

variable "mastodon_smtp_delivery_method" {}

variable "mastodon_smtp_domain" {}

variable "mastodon_smtp_enable_starttls_auto" {}

variable "mastodon_smtp_from_address" {}

variable "mastodon_smtp_login" {}

variable "mastodon_smtp_openssl_verify_mode" {}

variable "mastodon_smtp_password" {}

variable "mastodon_smtp_port" {}

variable "mastodon_smtp_server" {}

variable "mastodon_node_streaming_api_base_url" {}

variable "mastodon_node_streaming_cluster_num" {}

variable "mastodon_node_streaming_port" {
  default = "4000"
}
