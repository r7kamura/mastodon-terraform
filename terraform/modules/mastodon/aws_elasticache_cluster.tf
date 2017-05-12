resource "aws_elasticache_cluster" "mastodon" {
  cluster_id           = "${var.aws_resource_base_name}"
  engine               = "redis"
  node_type            = "${var.aws_elasticache_cluster_node_type}"
  port                 = 6379
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  maintenance_window   = "sun:20:00-sun:21:00"
  subnet_group_name    = "${aws_elasticache_subnet_group.mastodon.name}"
  security_group_ids   = ["${aws_security_group.mastodon_elasticache.id}"]
}
