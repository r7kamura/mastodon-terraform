resource "aws_db_instance" "mastodon" {
  allocated_storage          = 20
  auto_minor_version_upgrade = true
  backup_retention_period    = 7
  backup_window              = "20:00-21:00"
  db_subnet_group_name       = "${aws_db_subnet_group.mastodon.name}"
  engine                     = "postgres"
  engine_version             = "9.6.1"
  identifier                 = "mastodon"
  instance_class             = "db.t2.micro"
  multi_az                   = false
  name                       = "mastodon"
  parameter_group_name       = "${aws_db_parameter_group.mastodon.name}"
  password                   = "${var.mastodon_db_pass}"
  skip_final_snapshot        = true
  username                   = "${var.mastodon_db_user}"

  vpc_security_group_ids = [
    "${aws_security_group.mastodon_db.id}",
  ]
}
