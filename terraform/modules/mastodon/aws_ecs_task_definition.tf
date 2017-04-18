resource "aws_ecs_task_definition" "mastodon_db_migration" {
  family = "mastodon_db_migration"

  container_definitions = <<-JSON
[
  {
    "command": ["bundle", "exec", "rake", "db:migrate"],
    "environment": [
      {
        "name": "DATABASE_URL",
        "value": "mysql2://${var.mastodon_db_root_username}:${var.mastodon_db_root_password}@${aws_db_instance.mastodon.address}/${aws_db_instance.mastodon.name}"
      },
      {
        "name": "RAILS_ENV",
        "value": "production"
      },
      {
        "name": "SECRET_KEY_BASE",
        "value": "${var.mastodon_secret_key_base}"
      },
      {
        "name": "SIDEKIQ_REDIS_URL",
        "value": "redis://${aws_elasticache_cluster.mastodon.cache_nodes.0.address}:${aws_elasticache_cluster.mastodon.cache_nodes.0.port}/0"
      },
    ],
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
    "environment": [
      {
        "name": "DATABASE_URL",
        "value": "mysql2://${var.mastodon_db_root_username}:${var.mastodon_db_root_password}@${aws_db_instance.mastodon.address}/${aws_db_instance.mastodon.name}"
      },
      {
        "name": "RAILS_ENV",
        "value": "production"
      },
      {
        "name": "SECRET_KEY_BASE",
        "value": "${var.mastodon_secret_key_base}"
      },
      {
        "name": "SIDEKIQ_REDIS_URL",
        "value": "redis://${aws_elasticache_cluster.mastodon.cache_nodes.0.address}:${aws_elasticache_cluster.mastodon.cache_nodes.0.port}/0"
      },
    ],
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
    "environment": [
      {
        "name": "DATABASE_URL",
        "value": "mysql2://${var.mastodon_db_root_username}:${var.mastodon_db_root_password}@${aws_db_instance.mastodon.address}/${aws_db_instance.mastodon.name}"
      },
      {
        "name": "RAILS_ENV",
        "value": "production"
      },
      {
        "name": "SECRET_KEY_BASE",
        "value": "${var.mastodon_secret_key_base}"
      },
      {
        "name": "SIDEKIQ_REDIS_URL",
        "value": "redis://${aws_elasticache_cluster.mastodon.cache_nodes.0.address}:${aws_elasticache_cluster.mastodon.cache_nodes.0.port}/0"
      },
    ],
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
    "environment": [
      {
        "name": "DB_HOST",
        "value": "",
      },
      {
        "name": "DB_NAME",
        "value": "",
      },
      {
        "name": "DB_PASS",
        "value": "",
      },
      {
        "name": "DB_PORT",
        "value": "",
      },
      {
        "name": "DB_USER",
        "value": "",
      },
      {
        "name": "LOG_LEVEL",
        "value": "",
      },
      {
        "name": "NODE_ENV",
        "value": "production"
      },
      {
        "name": "PORT",
        "value": "",
      },
      {
        "name": "REDIS_HOST",
        "value": "",
      },
      {
        "name": "REDIS_PASSWOR",
        "value": "",
      },
      {
        "name": "REDIS_PORT",
        "value": "",
      }
    ],
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
