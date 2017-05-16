resource "aws_appautoscaling_policy" "mastodon_scale_in" {
  adjustment_type         = "ChangeInCapacity"
  cooldown                = 300
  depends_on              = ["aws_appautoscaling_target.mastodon"]
  metric_aggregation_type = "Average"
  name                    = "${var.aws_resource_base_name}-scale-in"
  resource_id             = "service/${aws_ecs_cluster.mastodon.name}/${aws_ecs_service.mastodon_rails_puma.name}"
  scalable_dimension      = "ecs:service:DesiredCount"
  service_namespace       = "ecs"

  step_adjustment {
    metric_interval_lower_bound = 0
    scaling_adjustment          = -1
  }
}

resource "aws_appautoscaling_policy" "mastodon_scale_out" {
  adjustment_type         = "ChangeInCapacity"
  cooldown                = 300
  depends_on              = ["aws_appautoscaling_target.mastodon"]
  metric_aggregation_type = "Average"
  name                    = "${var.aws_resource_base_name}-scale-out"
  resource_id             = "service/${aws_ecs_cluster.mastodon.name}/${aws_ecs_service.mastodon_rails_puma.name}"
  scalable_dimension      = "ecs:service:DesiredCount"
  service_namespace       = "ecs"

  step_adjustment {
    metric_interval_lower_bound = 0
    scaling_adjustment          = 1
  }
}
