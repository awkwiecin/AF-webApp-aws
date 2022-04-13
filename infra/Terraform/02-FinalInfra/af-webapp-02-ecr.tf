resource "aws_ecr_repository" "ecr" {
  name = "${var.user_prefix}-repository"
}