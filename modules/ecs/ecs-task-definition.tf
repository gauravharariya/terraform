# Service permission define
resource "aws_iam_role" "ecs_task_execution_role" {
  name = var.appname_prefix

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "ecs_policy" {
  name        = "${var.naming}-ecs-policy"
  description = "Policy that allows access to ECS ECR"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:BatchCheckLayerAvailability",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
  ]
}
EOF
}

# Service permission apply 
resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "ecs_task_role_ssm_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMReadOnlyAccess"
}


resource "aws_iam_role_policy_attachment" "ecs_task_role_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_policy.arn
}

# # Aws log group
# resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
#   name = "${var.appname_prefix}/${var.appname_prefix}-${var.aws_region}-${var.ecs_suffix}-${var.cw_log_group_suffix}"

#   tags = merge(var.common_tags,
#     {
#       Name = "${var.appname_prefix}-${var.aws_region}-${var.ecs_suffix}-${var.cw_log_group_suffix}"
#   })
# }

# Task Definition  
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                   = "${var.appname_prefix}-${var.ecs_scope}-${var.task_definition_suffix}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.container_cpu
  memory                   = var.container_memory
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name      = "${var.appname_prefix}-${var.ecs_scope}-${var.container_suffix}"
      image     = "${var.container_image}"
      essential = true
      portMappings = var.container_port == 0 ? null : [
        {
          protocol      = "tcp"
          containerPort = "${var.container_port}"
          hostPort      = "${var.container_port}"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = "${var.appname_prefix}/${var.appname_prefix}-${var.aws_region}-${var.ecs_suffix}-${var.cw_log_group_suffix}"
          awslogs-stream-prefix = "${var.appname_prefix}"
          awslogs-region        = "${var.aws_region}"
        }
      }

  }])

  lifecycle {
    ignore_changes = [container_definitions]
  }

  tags = merge(var.common_tags,
    {
      Name = "${var.appname_prefix}-${var.ecs_scope}-${var.task_definition_suffix}"
  })
}