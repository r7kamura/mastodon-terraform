resource "aws_launch_configuration" "mastodon" {
  associate_public_ip_address = true
  iam_instance_profile        = "${aws_iam_instance_profile.mastodon.id}"
  image_id                    = "${var.aws_launch_configuration_ami_id}"
  instance_type               = "t2.micro"
  name                        = "mastodon"
  security_groups             = ["${aws_security_group.mastodon_web.id}"]
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER='${aws_ecs_cluster.mastodon.name}' >> /etc/ecs/ecs.config"
}
