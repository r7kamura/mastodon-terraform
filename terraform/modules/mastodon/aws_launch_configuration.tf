resource "aws_launch_configuration" "mastodon" {
  associate_public_ip_address = true
  depends_on                  = ["aws_internet_gateway.mastodon"]
  iam_instance_profile        = "${aws_iam_instance_profile.mastodon.id}"
  image_id                    = "${lookup(var.aws_ecs_optimized_ami_ids, data.aws_region.current.name)}"
  instance_type               = "${var.aws_launch_configuration_mastodon_instance_type}"
  name_prefix                 = "mastodon-"
  security_groups             = ["${aws_security_group.mastodon_web.id}"]
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER='${aws_ecs_cluster.mastodon.name}' >> /etc/ecs/ecs.config"
}
