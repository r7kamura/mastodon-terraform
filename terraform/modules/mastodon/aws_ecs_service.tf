resource "aws_ecs_service" "mastodon_puma" {
  cluster                            = "${aws_ecs_cluster.mastodon.id}"
  depends_on                         = ["aws_iam_policy_attachment.mastodon_ecs_service"]
  deployment_minimum_healthy_percent = 50
  desired_count                      = 1
  iam_role                           = "${aws_iam_role.mastodon_ecs.arn}"

  load_balancer {
    container_name   = "mastodon_puma"
    container_port   = "3000"
    target_group_arn = "${aws_alb_target_group.mastodon.arn}"
  }

  name            = "mastodon_puma"
  task_definition = "${aws_ecs_task_definition.mastodon_puma.arn}"
}

resource "aws_ecs_service" "mastodon_sidekiq" {
  cluster                            = "${aws_ecs_cluster.mastodon.id}"
  depends_on                         = ["aws_iam_policy_attachment.mastodon_ecs_service"]
  deployment_minimum_healthy_percent = 50
  desired_count                      = 1
  name                               = "mastodon_sidekiq"
  task_definition                    = "${aws_ecs_task_definition.mastodon_sidekiq.arn}"
}
