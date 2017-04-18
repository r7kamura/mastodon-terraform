resource "aws_ecs_task_definition" "mastodon_db_migration" {
  family = "mastodon_db_migration"

  container_definitions = <<-JSON
[
  {
    "command": ["bundle", "exec", "rake", "db:migrate"],
    "environment": ${data.template_file.mastodon_environment_variables_rails.rendered},
    "image": "${replace(aws_ecr_repository.mastodon_rails.repository_url, "https://", "")}:${var.mastodon_docker_image_tag}",
    "memory": 490,
    "name": "mastodon_db_migration"
  }
]
  JSON
}

resource "aws_ecs_task_definition" "mastodon_puma" {
  family = "mastodon_puma"

  container_definitions = <<-JSON
[
  {
    "command": ["bundle", "exec", "puma", "--config", "config/puma.rb", "--environment", "production"],
    "environment": ${data.template_file.mastodon_environment_variables_rails.rendered},
    "image": "${replace(aws_ecr_repository.mastodon_rails.repository_url, "https://", "")}:${var.mastodon_docker_image_tag}",
    "memory": 490,
    "name": "mastodon_puma",
    "portMappings": [
      {
        "containerPort": 3000,
        "protocol": "tcp"
      }
    ]
  }
]
  JSON
}

resource "aws_ecs_task_definition" "mastodon_sidekiq" {
  family = "mastodon_sidekiq"

  container_definitions = <<-JSON
[
  {
    "command": ["bundle", "exec", "sidekiq", "--queue", "high", "--queue", "low"],
    "environment": ${data.template_file.mastodon_environment_variables_rails.rendered},
    "image": "${replace(aws_ecr_repository.mastodon_rails.repository_url, "https://", "")}:${var.mastodon_docker_image_tag}",
    "memory": 490,
    "name": "mastodon_sidekiq"
  }
]
  JSON
}

resource "aws_ecs_task_definition" "mastodon_streaming" {
  family = "mastodon_streaming"

  container_definitions = <<-JSON
[
  {
    "command": ["yarn", "run", "start"],
    "environment": ${data.template_file.mastodon_environment_variables_streaming.rendered},
    "image": "${replace(aws_ecr_repository.mastodon_node.repository_url, "https://", "")}:${var.mastodon_docker_image_tag}",
    "memory": 490,
    "name": "mastodon_streaming",
    "portMappings": [
      {
        "containerPort": 4000,
        "protocol": "tcp"
      }
    ]
  }
]
  JSON
}
