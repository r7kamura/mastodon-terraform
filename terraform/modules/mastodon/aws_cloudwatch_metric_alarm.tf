resource "aws_cloudwatch_metric_alarm" "mastodon_cluster_cpu_high" {
  alarm_actions       = ["${aws_autoscaling_policy.mastodon_scale_out.arn}"]
  alarm_name          = "${var.aws_resource_base_name}-cluster-cpu-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"

  dimensions {
    ClusterName = "${aws_ecs_cluster.mastodon.name}"
  }

  evaluation_periods = "3"
  metric_name        = "CPUUtilization"
  namespace          = "AWS/ECS"
  period             = "300"
  statistic          = "Average"
  threshold          = "65"
}

resource "aws_cloudwatch_metric_alarm" "mastodon_cluster_cpu_low" {
  alarm_actions       = ["${aws_autoscaling_policy.mastodon_scale_in.arn}"]
  alarm_name          = "${var.aws_resource_base_name}-cluster-cpu-low"
  comparison_operator = "LessThanThreshold"

  dimensions {
    ClusterName = "${aws_ecs_cluster.mastodon.name}"
  }

  evaluation_periods = "3"
  metric_name        = "CPUUtilization"
  namespace          = "AWS/ECS"
  period             = "300"
  statistic          = "Average"
  threshold          = "20"
}

resource "aws_cloudwatch_metric_alarm" "mastodon_service_cpu_high" {
  alarm_actions       = ["${aws_appautoscaling_policy.mastodon_scale_out.arn}"]
  alarm_name          = "${var.aws_resource_base_name}-service-cpu-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"

  dimensions {
    ClusterName = "${aws_ecs_cluster.mastodon.name}"
    ServiceName = "${aws_ecs_service.mastodon_rails_puma.name}"
  }

  evaluation_periods = "3"
  metric_name        = "CPUUtilization"
  namespace          = "AWS/ECS"
  period             = "300"
  statistic          = "Average"
  threshold          = "65"
}

resource "aws_cloudwatch_metric_alarm" "mastodon_service_cpu_low" {
  alarm_actions       = ["${aws_appautoscaling_policy.mastodon_scale_in.arn}"]
  alarm_name          = "${var.aws_resource_base_name}-service-cpu-low"
  comparison_operator = "LessThanThreshold"

  dimensions {
    ClusterName = "${aws_ecs_cluster.mastodon.name}"
    ServiceName = "${aws_ecs_service.mastodon_rails_puma.name}"
  }

  evaluation_periods = "3"
  metric_name        = "CPUUtilization"
  namespace          = "AWS/ECS"
  period             = "300"
  statistic          = "Average"
  threshold          = "20"
}
