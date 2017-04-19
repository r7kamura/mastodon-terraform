resource "aws_ecs_task_definition" "mastodon_node_streaming" {
  family = "mastodon_node_streaming"

  container_definitions = <<-JSON
  [
    {
      "command": ["yarn", "run", "start"],
      "environment": ${data.template_file.mastodon_environment_variables_streaming.rendered},
      "image": "${replace(aws_ecr_repository.mastodon.repository_url, "https://", "")}:${var.mastodon_docker_image_tag}",
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "mastodon",
          "awslogs-region": "${data.aws_region.current.name}",
          "awslogs-stream-prefix": "streaming"
        }
      },
      "memory": ${var.aws_ecs_task_definition_mastodon_node_streaming_memory},
      "name": "mastodon_node_streaming",
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

resource "aws_ecs_task_definition" "mastodon_rails_db_migration" {
  family = "mastodon_rails_db_migration"

  container_definitions = <<-JSON
  [
    {
      "command": ["bundle", "exec", "rake", "db:migrate"],
      "environment": ${data.template_file.mastodon_environment_variables_rails.rendered},
      "image": "${replace(aws_ecr_repository.mastodon.repository_url, "https://", "")}:${var.mastodon_docker_image_tag}",
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "mastodon",
          "awslogs-region": "${data.aws_region.current.name}",
          "awslogs-stream-prefix": "rails_db_migration"
        }
      },
      "memory": ${var.aws_ecs_task_definition_mastodon_rails_db_migration_memory},
      "name": "mastodon_rails_db_migration"
    }
  ]
  JSON
}

resource "aws_ecs_task_definition" "mastodon_rails_db_set_up" {
  family = "mastodon_rails_db_set_up"

  container_definitions = <<-JSON
  [
    {
      "command": ["bundle", "exec", "rails", "db:setup"],
      "environment": ${data.template_file.mastodon_environment_variables_rails.rendered},
      "image": "${replace(aws_ecr_repository.mastodon.repository_url, "https://", "")}:${var.mastodon_docker_image_tag}",
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "mastodon",
          "awslogs-region": "${data.aws_region.current.name}",
          "awslogs-stream-prefix": "rails_db_set_up"
        }
      },
      "memory": ${var.aws_ecs_task_definition_mastodon_rails_db_set_up_memory},
      "name": "mastodon_rails_db_set_up"
    }
  ]
  JSON
}

resource "aws_ecs_task_definition" "mastodon_rails_puma" {
  family = "mastodon_rails_puma"

  container_definitions = <<-JSON
  [
    {
      "command": ["bundle", "exec", "puma", "--config", "config/puma.rb", "--environment", "production"],
      "environment": ${data.template_file.mastodon_environment_variables_rails.rendered},
      "image": "${replace(aws_ecr_repository.mastodon.repository_url, "https://", "")}:${var.mastodon_docker_image_tag}",
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "mastodon",
          "awslogs-region": "${data.aws_region.current.name}",
          "awslogs-stream-prefix": "rails_puma"
        }
      },
      "memory": ${var.aws_ecs_task_definition_mastodon_rails_puma_memory},
      "name": "mastodon_rails_puma",
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

resource "aws_ecs_task_definition" "mastodon_rails_sidekiq" {
  family = "mastodon_rails_sidekiq"

  container_definitions = <<-JSON
  [
    {
      "command": ["bundle", "exec", "sidekiq", "--queue", "default", "--queue", "mailers", "--queue", "--pull", "--queue", "push"],
      "environment": ${data.template_file.mastodon_environment_variables_rails.rendered},
      "image": "${replace(aws_ecr_repository.mastodon.repository_url, "https://", "")}:${var.mastodon_docker_image_tag}",
      "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
          "awslogs-group": "mastodon",
          "awslogs-region": "${data.aws_region.current.name}",
          "awslogs-stream-prefix": "rails_sidekiq"
        }
      },
      "memory": ${var.aws_ecs_task_definition_mastodon_rails_sidekiq_memory},
      "name": "mastodon_rails_sidekiq"
    }
  ]
  JSON
}
