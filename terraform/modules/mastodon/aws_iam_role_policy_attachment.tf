resource "aws_iam_role_policy_attachment" "mastodon_ecs_ec2_instance" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
  role       = "${aws_iam_role.mastodon_ec2.id}"
}

resource "aws_iam_role_policy_attachment" "mastodon_ecs_autoscaling" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
  role       = "${aws_iam_role.mastodon_ecs_autoscaling.id}"
}

resource "aws_iam_role_policy_attachment" "mastodon_ecs_service" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
  role       = "${aws_iam_role.mastodon_ecs.id}"
}
