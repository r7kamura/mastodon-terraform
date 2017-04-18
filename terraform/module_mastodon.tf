module "mastodon" {
  aws_launch_configuration_ami_id = "${var.aws_launch_configuration_ami_id}"
  aws_region                      = "${var.aws_region}"
  mastodon_db_root_password       = "${var.mastodon_db_root_password}"
  mastodon_db_root_username       = "${var.mastodon_db_root_username}"
  mastodon_docker_image_tag       = "${var.mastodon_docker_image_tag}"
  mastodon_secret_key_base        = "${var.mastodon_secret_key_base}"
  source                          = "./modules/mastodon"
}
