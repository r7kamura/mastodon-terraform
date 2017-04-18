resource "aws_iam_policy_attachment" "mastodon_ecs_ec2_instance" {
  name       = "mastodon_ecs_ec2_instance"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  roles      = ["${aws_iam_role.mastodon_ec2.id}"]
}

resource "aws_iam_policy_attachment" "mastodon_ecs_service" {
  name       = "mastodon_ecs_service"
  roles      = ["${aws_iam_role.mastodon_ecs.id}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}
