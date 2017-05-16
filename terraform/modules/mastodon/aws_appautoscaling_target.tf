resource "aws_appautoscaling_target" "mastodon" {
  max_capacity       = 2
  min_capacity       = 1
  resource_id        = "service/${aws_ecs_cluster.mastodon.name}/${aws_ecs_service.mastodon_rails_puma.name}"
  role_arn           = "${aws_iam_role.mastodon_ecs_autoscaling.arn}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}
