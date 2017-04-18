# mastodon-terraform

Boilerplate for running [Mastodon](https://github.com/tootsuite/mastodon) on AWS by [Terraform](https://github.com/hashicorp/terraform).

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

```bash
docker-compose run --rm terraform init \
  -backend=true \
  -backend-config="bucket=${AWS_S3_BUCKET_TERRAFORM_STATE_NAME}" \
  -backend-config="key=${AWS_S3_BUCKET_TERRAFORM_STATE_KEY}" \
  -backend-config="region=${AWS_S3_BUCKET_TERRAFORM_STATE_REGION}"
```
