resource "aws_security_group" "ecs_sg" {
  vpc_id = data.aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_iam_policy_document" "ecs_agent" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ecs_agent" {
  name               = "${var.user_prefix}-ecs-agent"
  assume_role_policy = data.aws_iam_policy_document.ecs_agent.json
}

resource "aws_iam_role_policy_attachment" "ecs_agent" {
  role       = aws_iam_role.ecs_agent.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "ecs_agent" {
  name = "${var.user_prefix}-ecs-agent"
  role = aws_iam_role.ecs_agent.name
}

resource "aws_launch_configuration" "ecs_launch_config" {
  image_id                    = "ami-0c114f68881dc4f44"
  iam_instance_profile        = aws_iam_instance_profile.ecs_agent.name
  security_groups             = [aws_security_group.ecs_sg.id]
  user_data                   = "#!/bin/bash\n echo ECS_CLUSTER=${aws_ecs_cluster.ecs.name} >> /etc/ecs/ecs.config"
  instance_type               = "t2.micro"
  associate_public_ip_address = true
}

resource "aws_autoscaling_group" "asg" {
  name                 = "asg"
  vpc_zone_identifier  = [data.aws_subnet.snet.id]
  launch_configuration = aws_launch_configuration.ecs_launch_config.name

  desired_capacity          = 1
  min_size                  = 1
  max_size                  = 10
  health_check_grace_period = 300
  health_check_type         = "EC2"
}
