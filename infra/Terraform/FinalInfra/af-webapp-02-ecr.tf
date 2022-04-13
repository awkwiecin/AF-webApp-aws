resource "aws_ecs_cluster" "ecs" {
  name = "${var.user_prefix}-cluster"
}
