resource "aws_db_parameter_group" "mastodon" {
  name        = "mastodon"
  description = "mastodon"
  family      = "mysql5.6"

  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_connection"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_filesystem"
    value = "binary"
  }

  parameter {
    name  = "character_set_results"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "collation_server"
    value = "utf8mb4_general_ci"
  }

  parameter {
    name  = "innodb_lock_wait_timeout"
    value = "2"
  }

  parameter {
    name  = "long_query_time"
    value = "0.5"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "skip-character-set-client-handshake"
    value        = "0"
  }

  parameter {
    name  = "slow_query_log"
    value = "1"
  }
}
