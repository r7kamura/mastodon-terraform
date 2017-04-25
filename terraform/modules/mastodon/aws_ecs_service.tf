resource "aws_ecs_service" "mastodon_node_streaming" {
  cluster                            = "${aws_ecs_cluster.mastodon.id}"
  deployment_minimum_healthy_percent = 50
  desired_count                      = 1
  iam_role                           = "${aws_iam_role.mastodon_ecs.arn}"
  name                               = "mastodon_node_streaming"

  load_balancer {
    container_name   = "mastodon_node_streaming"
    container_port   = "${var.mastodon_node_streaming_port}"
    target_group_arn = "${aws_alb_target_group.mastodon_node_streaming.arn}"
  }

  task_definition = "${aws_ecs_task_definition.mastodon_node_streaming.arn}"
}

resource "aws_ecs_service" "mastodon_rails_puma" {
  cluster                            = "${aws_ecs_cluster.mastodon.id}"
  deployment_minimum_healthy_percent = 50
  desired_count                      = 1
  iam_role                           = "${aws_iam_role.mastodon_ecs.arn}"
  name                               = "mastodon_rails_puma"

  load_balancer {
    container_name   = "mastodon_rails_puma"
    container_port   = "3000"
    target_group_arn = "${aws_alb_target_group.mastodon_rails_puma.arn}"
  }

  task_definition = "${aws_ecs_task_definition.mastodon_rails_puma.arn}"
}

resource "aws_ecs_service" "mastodon_rails_sidekiq" {
  cluster                            = "${aws_ecs_cluster.mastodon.id}"
  deployment_minimum_healthy_percent = 50
  desired_count                      = 1
  name                               = "mastodon_rails_sidekiq"
  task_definition                    = "${aws_ecs_task_definition.mastodon_rails_sidekiq.arn}"
}
