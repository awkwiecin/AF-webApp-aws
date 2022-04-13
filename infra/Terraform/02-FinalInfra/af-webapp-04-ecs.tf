resource "aws_ecs_task_definition" "service" {
  family             = "${var.user_prefix}-definition"
  cpu                = "1vcpu"
  memory             = "512"
  execution_role_arn = aws_iam_role.ecsTaskExecutionRole.arn
  task_role_arn      = aws_iam_role.ecsTaskExecutionRole.arn

  container_definitions = jsonencode([
    {
      name      = "hello-world-container"
      image     = "${aws_ecr_repository.ecr.repository_url}:latest"
      cpu       = 1
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "service" {
  name                    = "${var.user_prefix}-service"
  cluster                 = aws_ecs_cluster.ecs.id
  task_definition         = aws_ecs_task_definition.service.arn
  desired_count           = 1
  enable_ecs_managed_tags = true
  launch_type             = "EC2"
}