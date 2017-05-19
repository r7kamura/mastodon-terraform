# mastodon-terraform

Boilerplate for running [Mastodon](https://github.com/tootsuite/mastodon) on AWS using [Terraform](https://github.com/hashicorp/terraform) and [CircleCI](http://circleci.com/).

```
┌---------------┐
|  Web Browser  |
└---------------┘
▲               ▲
|               |
(HTTPS)         (WSS)
|               |
▼               |
┌------------┐  |
| CloudFront |  |
└------------┘  |
▲               |
|               |
(HTTP)          |
|               |
▼               ▼
┌---------------┐
|      ALB      |
└---------------┘
▲               ▲
|               |
(HTTP)          (WS)
|               |
▼               ▼
┌------------------------┐
| ┌-Docker-┐ ┌-Docker--┐ |
| |  Puma  | | Express | |
| └--------┘ └---------┘ |
| ┌-Docker--┐            |
| | Sidekiq |     EC2    |
| └---------┘            |
└------------------------┘
▲                  ▲
|                  |
▼                  ▼
┌----------------┐ ┌-------------┐
| ┌------------┐ | |  ┌-------┐  |
| | PostgreSQL | | |  | Redis |  |
| └------------┘ | |  └-------┘  |
|       RDS      | | Elasticache |
└----------------┘ └-------------┘
```

## Usage

1. Fork this repository
1. Enable CircleCI integration
1. Set environment variables on CircleCI
1. Run CircleCI job to create resources on AWS
1. Build and push mastodon docker image via [mastodon-docker](https://github.com/r7kamura/mastodon-docker)
1. Run `rails db:setup` by running custom ECS task on AWS console

## Required environment variables

### AWS_ACCESS_KEY_ID

AWS IAM User access key ID for Terraform.

e.g. `ABCDEFGHIJKLMNOPQRST`

### AWS_DEFAULT_REGION

AWS region that the resources will be located in.

e.g. `ap-northeast-1`

### AWS_SECRET_ACCESS_KEY

AWS IAM User secret access key for Terraform.

e.g. `abcdefghijklmnopqrstuvwxyz0123456789/+AB`

### AWS_S3_BUCKET_TERRAFORM_STATE_NAME

The domain that your terraform state file will be stored.
To run Terraform from CircleCI, you need to prepare a private AWS S3 bucket to store your terraform state file.

e.g. `your-s3-bucket-name`

### AWS_S3_BUCKET_TERRAFORM_STATE_KEY

Where to locate the terraform state file on the specified AWS S3 bucket.

e.g. `terraform.tfstate` (recommended)

### TF_VAR_aws_s3_bucket_name

A valid S3 bucket name for uploading files (e.g. user profile images).

e.g. `my-mastodon`

### TF_VAR_mastodon_s3_cloudfront_host

The domain for the CloudFront distribution where uploaded files will be provided from.

e.g. `cdn.example.com`

### TF_VAR_mastodon_db_pass

Database password.

e.g. Generate a long random value like this:

```bash
ruby -r securerandom -e "puts SecureRandom.hex(64)"
```

### TF_VAR_mastodon_docker_image_tag

Mastodon Docker image tag to detect which image to be deployed on ECS.
If you are using [mastodon-docker](https://github.com/r7kamura/mastodon-docker) to build and push it to ECR,
the CircleCI build number will be the Docker image tag.

e.g. `123`

Note: this variable is not required at the 1st time because we need to create ECR repository before building Mastodon Docker image.

### TF_VAR_mastodon_local_domain

The domain that your Mastodon instance will run on.

e.g. `mastodon.example.com`

### TF_VAR_mastodon_otp_secret

One-time password secret

e.g. Generate a long random value like this:

```bash
ruby -r securerandom -e "puts SecureRandom.hex(64)"
```

### TF_VAR_mastodon_secret_key_base

The secret key base.

e.g. Generate a long random value like this:

```bash
ruby -r securerandom -e "puts SecureRandom.hex(64)"
```

## Optional environment variables

### TF_VAR_aws_acm_certificate_arn

If you want to use HTTPS,
create free SSL certificate for your domain on Amazon Certificate Manager on us-east-1 region,
then set its ARN to this environment variable.

e.g. `arn:aws:acm:us-east-1:123456789012:certificate/12345678-90ab-cdef-1234-567890abcdef`

### TF_VAR_aws_acm_certificate_arn_for_alb

For using secure WebSocket connection,
create free SSL certificate for your domain on Amazon Certificate Manager on your region,
then set its ARN to this environment variable too.

e.g. `arn:aws:acm:ap-northeast-1:123456789012:certificate/12345678-90ab-cdef-1234-567890abcdef`

### TF_VAR_aws_db_instance_mastodon_instance_class

AWS RDS DB instance class.

default: `db.t2.micro`

FYI: http://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Concepts.DBInstanceClass.html.

### TF_VAR_aws_ecs_task_definition_mastodon_node_streaming_memory

Memory size for node_streaming ECS task.

default: `300`

### TF_VAR_aws_ecs_task_definition_mastodon_rails_db_migration_memory

Memory size for rails_db_migration ECS task.

default: `300`

### TF_VAR_aws_ecs_task_definition_mastodon_rails_db_set_up_memory

Memory size for rails_db_set_up ECS task.

default: `300`

### TF_VAR_aws_ecs_task_definition_mastodon_rails_mastodon_make_admin_memory

Memory size for rails_mastodon_make_admin_memory ECS task.

default: `300`

### TF_VAR_aws_ecs_task_definition_mastodon_rails_puma_memory

Memory size for rails_puma ECS task.

default: `300`

### TF_VAR_aws_ecs_task_definition_mastodon_rails_sidekiq_memory

Memory size for rails_sidekiq ECS task.

default: `300`

### TF_VAR_aws_elasticache_cluster_node_type

AWS Elasticache Cluster node type.

default: `cache.t2.micro`

FYI: https://aws.amazon.com/jp/elasticache/pricing/.

### TF_VAR_aws_launch_configuration_mastodon_instance_type

AWS EC2 instance type.

default: `t2.micro`

FYI: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html.

### TF_VAR_mastodon_administrator_name

Administrator user name for the `mastodon_rails_mastodon_make_admin` ECS task.

### TF_VAR_mastodon_aws_access_key_id

AWS IAM user access key ID for Rails to access to AWS API.

### TF_VAR_mastodon_aws_secret_access_key

AWS IAM user secret access key for Rails to access to AWS API.

### TF_VAR_mastodon_db_name

DB name.

default: `mastodon`

### TF_VAR_mastodon_db_user

DB user name.

default: `root`

### TF_VAR_mastodon_default_locale

Default locale.

default: `en`

### TF_VAR_mastodon_email_domain_blacklist

Email domain blacklist.

### TF_VAR_mastodon_email_domain_whitelist

Email domain whitelist.

### TF_VAR_mastodon_node_streaming_api_base_url

The base URL of Streaming API endpoint.

e.g. `https://mastodon-streaming.example.com:4000`

### TF_VAR_mastodon_node_streaming_cluster_num

default: `1`

### TF_VAR_mastodon_single_user_mode

Should the instance run in single user mode? (Disable registrations, redirect to front page)

default: `false`

### Others

- `TF_VAR_mastodon_paperclip_root_path`
- `TF_VAR_mastodon_paperclip_root_url`
- `TF_VAR_mastodon_paperclip_secret`
- `TF_VAR_mastodon_prepared_statements`
- `TF_VAR_mastodon_smtp_auth_method`
- `TF_VAR_mastodon_smtp_delivery_method`
- `TF_VAR_mastodon_smtp_domain`
- `TF_VAR_mastodon_smtp_enable_starttls_auto`
- `TF_VAR_mastodon_smtp_from_address`
- `TF_VAR_mastodon_smtp_login`
- `TF_VAR_mastodon_smtp_openssl_verify_mode`
- `TF_VAR_mastodon_smtp_password`
- `TF_VAR_mastodon_smtp_port`
- `TF_VAR_mastodon_smtp_server`

## Resources

This boilerplate will create the following resources:

- module.mastodon.aws_alb_listener.mastodon_node_streaming:
- module.mastodon.aws_alb_listener.mastodon_rails_puma:
- module.mastodon.aws_alb_target_group.mastodon_node_streaming:
- module.mastodon.aws_alb_target_group.mastodon_rails_puma:
- module.mastodon.aws_alb.mastodon:
- module.mastodon.aws_autoscaling_group.mastodon:
- module.mastodon.aws_cloudfront_distribution.mastodon:
- module.mastodon.aws_cloudwatch_log_group.mastodon:
- module.mastodon.aws_db_instance.mastodon:
- module.mastodon.aws_db_parameter_group.mastodon:
- module.mastodon.aws_db_subnet_group.mastodon:
- module.mastodon.aws_ecr_repository.mastodon:
- module.mastodon.aws_ecs_cluster.mastodon:
- module.mastodon.aws_ecs_service.mastodon_node_streaming:
- module.mastodon.aws_ecs_service.mastodon_rails_puma:
- module.mastodon.aws_ecs_service.mastodon_rails_sidekiq:
- module.mastodon.aws_ecs_task_definition.mastodon_node_streaming:
- module.mastodon.aws_ecs_task_definition.mastodon_rails_db_migration:
- module.mastodon.aws_ecs_task_definition.mastodon_rails_db_set_up:
- module.mastodon.aws_ecs_task_definition.mastodon_rails_puma:
- module.mastodon.aws_ecs_task_definition.mastodon_rails_sidekiq:
- module.mastodon.aws_elasticache_cluster.mastodon:
- module.mastodon.aws_elasticache_subnet_group.mastodon:
- module.mastodon.aws_iam_instance_profile.mastodon:
- module.mastodon.aws_iam_policy_attachment.mastodon_ecs_ec2_instance:
- module.mastodon.aws_iam_policy_attachment.mastodon_ecs_service:
- module.mastodon.aws_iam_role.mastodon_ec2:
- module.mastodon.aws_iam_role.mastodon_ecs:
- module.mastodon.aws_internet_gateway.mastodon:
- module.mastodon.aws_launch_configuration.mastodon:
- module.mastodon.aws_route_table_association.mastodon_a:
- module.mastodon.aws_route_table_association.mastodon_c:
- module.mastodon.aws_route_table.mastodon:
- module.mastodon.aws_security_group.mastodon_alb:
- module.mastodon.aws_security_group.mastodon_db:
- module.mastodon.aws_security_group.mastodon_elasticache:
- module.mastodon.aws_security_group.mastodon_web:
- module.mastodon.aws_subnet.mastodon_private_a:
- module.mastodon.aws_subnet.mastodon_private_c:
- module.mastodon.aws_subnet.mastodon_public_a:
- module.mastodon.aws_subnet.mastodon_public_c:
- module.mastodon.aws_vpc.mastodon:

## Contributing

Pull Requests are welcome if you found bugs or features you think are missing.
