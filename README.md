# mastodon-terraform

Boilerplate for running [Mastodon](https://github.com/tootsuite/mastodon) on AWS using [Terraform](https://github.com/hashicorp/terraform).

## Requirements

- Docker 1.13 or later version
- S3 bucket (to store terraform state)

## Usage

### Pull docker image

```bash
docker-compose pull
```

### Configure environment variables

```bash
cp .env.dummy .env
vi .env
```

### Initialize terraform state

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
