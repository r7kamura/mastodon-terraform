# mastodon-terraform

Boilerplate for running [Mastodon](https://github.com/tootsuite/mastodon) on AWS using [Terraform](https://github.com/hashicorp/terraform).

## Requirements

- [Docker](https://www.docker.com/) 1.13 or later version
- AWS S3 bucket (to store terraform state)
- [aws-cli](https://github.com/aws/aws-cli)

## Usage

### 1. Pull terraform docker image

```bash
docker-compose pull
```

### 2. Customize environment variables

```bash
cp .env.dummy .env
vi .env
```

See [terraform/variable.tf](/terraform/variable.tf) for more details about available variables.

### 3. Initialize terraform state

- `AWS_S3_BUCKET_TERRAFORM_STATE_NAME` (e.g. `my-mastodon-terraform-state`)
- `AWS_S3_BUCKET_TERRAFORM_STATE_KEY` (e.g. `terraform.tfstate`)
- `AWS_S3_BUCKET_TERRAFORM_STATE_REGION` (e.g. `ap-northeast-1`)

```bash
docker-compose run --rm terraform init \
  -backend=true \
  -backend-config="bucket=${AWS_S3_BUCKET_TERRAFORM_STATE_NAME}" \
  -backend-config="key=${AWS_S3_BUCKET_TERRAFORM_STATE_KEY}" \
  -backend-config="region=${AWS_S3_BUCKET_TERRAFORM_STATE_REGION}"
```

### 4. Create resources on AWS

```bash
docker-compose run --rm terraform apply
```

### 5. Build docker image

```bash
git clone https://github.com/tootsuite/mastodon.git
docker build --tag mastodon mastodon
docker run --env SECRET_KEY_BASE=dummy --volume $(pwd)/mastodon/public/assets:/mastodon/public/assets mastodon bundle exec rake assets:precompile
rm mastodon/.dockerignore
docker build --tag ${MASTODON_DOCKER_IMAGE_REPOSITORY_URL}:${TF_VAR_mastodon_docker_image_tag} mastodon
```

### 6. Push docker image

```bash
eval $(aws ecr get-login --region ${AWS_REGION})
docker push ${MASTODON_DOCKER_IMAGE_REPOSITORY_URL}:${TF_VAR_mastodon_docker_image_tag}
```

## Resources

This boilerplate will create the following resources:

- module.mastodon.aws_alb_listener.mastodon
- module.mastodon.aws_alb_target_group.mastodon
- module.mastodon.aws_alb.mastodon
- module.mastodon.aws_autoscaling_group.mastodon
- module.mastodon.aws_cloudwatch_log_group.mastodon
- module.mastodon.aws_db_instance.mastodon
- module.mastodon.aws_db_parameter_group.mastodon
- module.mastodon.aws_db_subnet_group.mastodon
- module.mastodon.aws_ecr_repository.mastodon
- module.mastodon.aws_ecs_cluster.mastodon
- module.mastodon.aws_ecs_service.mastodon_puma
- module.mastodon.aws_ecs_service.mastodon_sidekiq
- module.mastodon.aws_ecs_task_definition.mastodon_db_migration
- module.mastodon.aws_ecs_task_definition.mastodon_db_set_up
- module.mastodon.aws_ecs_task_definition.mastodon_puma
- module.mastodon.aws_ecs_task_definition.mastodon_sidekiq
- module.mastodon.aws_ecs_task_definition.mastodon_streaming
- module.mastodon.aws_elasticache_cluster.mastodon
- module.mastodon.aws_elasticache_subnet_group.mastodon
- module.mastodon.aws_iam_instance_profile.mastodon
- module.mastodon.aws_iam_policy_attachment.mastodon_ecs_ec2_instance
- module.mastodon.aws_iam_policy_attachment.mastodon_ecs_service
- module.mastodon.aws_iam_role.mastodon_ec2
- module.mastodon.aws_iam_role.mastodon_ecs
- module.mastodon.aws_internet_gateway.mastodon
- module.mastodon.aws_launch_configuration.mastodon
- module.mastodon.aws_route_table_association.mastodon_a
- module.mastodon.aws_route_table_association.mastodon_c
- module.mastodon.aws_route_table.mastodon
- module.mastodon.aws_security_group.mastodon_alb
- module.mastodon.aws_security_group.mastodon_db
- module.mastodon.aws_security_group.mastodon_elasticache
- module.mastodon.aws_security_group.mastodon_web
- module.mastodon.aws_subnet.mastodon_private_a
- module.mastodon.aws_subnet.mastodon_private_c
- module.mastodon.aws_subnet.mastodon_public_a
- module.mastodon.aws_subnet.mastodon_public_c
- module.mastodon.aws_vpc.mastodon
