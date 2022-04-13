resource "aws_ecs_cluster" "af-ecs-cluster-tf" {
  name = "af-ecs-cluster-tf"
}

resource "aws_ecs_service" "af-ecs-service" {
  name            = "af-ecs-service"
  cluster         = aws_ecs_cluster.af-ecs-cluster-tf.id
  task_definition = aws_ecs_task_definition.af-ecs-task-definition.arn
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = ["subnet-0c5ab4a1499db9f85"]
    assign_public_ip = true
  }
  desired_count = 1
}

resource "aws_ecs_task_definition" "af-ecs-task-definition" {
  family                   = "af-ecs-task-definition"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  memory                   = "1024"
  cpu                      = "512"
  execution_role_arn       = "arn:aws:iam::836906079004:role/ecsTaskExecutionRole"
  container_definitions    = <<EOF
[
  {
    "name": "af-ecr",
    "image": "836906079004.dkr.ecr.eu-central-1.amazonaws.com/af-ecr-tf",
    "memory": 1024,
    "cpu": 512,
    "essential": true,
    "entryPoint": ["/"],
    "portMappings": [
      {
        "containerPort": 80,
        "hostPort": 80
      }
    ]
  }
]
EOF
}