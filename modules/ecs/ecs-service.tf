# data "terraform_remote_state" "vpc" {
#   backend = "s3"
#   config = {
#     bucket = "phoenix-${var.environment}-terraform-state-bucket"
#     key    = "networking"
#     region = "${var.aws_region}"
#   }
# }

resource "aws_security_group" "ecs_tasks" {
  name   = var.naming
  vpc_id = var.rostra_vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = var.container_port
    to_port         = var.container_port

  }

  egress {
    protocol         = "-1"
    from_port        = 0
    to_port          = 0
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_ecs_service" "ecs_service" {
  name                               = "${var.naming}-${var.ecs_scope}"
  cluster                            = aws_ecs_cluster.ecs_cluster.id
  task_definition                    = aws_ecs_task_definition.ecs_task_definition.arn
  desired_count                      = var.service_desired_count
  force_new_deployment               = true
  deployment_minimum_healthy_percent = 100
  deployment_maximum_percent         = 200
  health_check_grace_period_seconds  = length(var.target_group_arn) > 0 ? 120 : null
  platform_version                   = var.platform_version
  launch_type                        = "FARGATE"
  scheduling_strategy                = var.scheduling_strategy
  enable_execute_command             = true
  deployment_controller {
    type = "ECS"
  }


  network_configuration {
    security_groups  = [aws_security_group.ecs_tasks.id]
    subnets          = var.private_subnet 
    assign_public_ip = false
  }

  dynamic "load_balancer" {
    for_each = length(var.target_group_arn) > 0 ? [var.target_group_arn] : []
    content {
      container_name   = "${var.naming}-${var.ecs_scope}-${var.container_suffix}"
      target_group_arn = var.target_group_arn
      container_port   = var.container_port
    }
  }

  lifecycle {
    ignore_changes = [task_definition, desired_count]
  }

}

# resource "aws_appautoscaling_target" "ecs_target" {
#   max_capacity       = var.max_capacity
#   min_capacity       = 1
#   resource_id        = "service/${var.ecs_cluster_name}/${aws_ecs_service.ecs_service.name}"
#   scalable_dimension = "ecs:service:DesiredCount"
#   service_namespace  = "ecs"
# }

# resource "aws_appautoscaling_policy" "ecs_policy_memory" {
#   name               = "memory-autoscaling"
#   policy_type        = "TargetTrackingScaling"
#   resource_id        = aws_appautoscaling_target.ecs_target.resource_id
#   scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
#   service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

#   target_tracking_scaling_policy_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ECSServiceAverageMemoryUtilization"
#     }

#     target_value       = 80
#     scale_in_cooldown  = 300
#     scale_out_cooldown = 300
#   }
# }

# resource "aws_appautoscaling_policy" "ecs_policy_cpu" {
#   name               = "cpu-autoscaling"
#   policy_type        = "TargetTrackingScaling"
#   resource_id        = aws_appautoscaling_target.ecs_target.resource_id
#   scalable_dimension = aws_appautoscaling_target.ecs_target.scalable_dimension
#   service_namespace  = aws_appautoscaling_target.ecs_target.service_namespace

#   target_tracking_scaling_policy_configuration {
#     predefined_metric_specification {
#       predefined_metric_type = "ECSServiceAverageCPUUtilization"
#     }

#     target_value       = 60
#     scale_in_cooldown  = 300
#     scale_out_cooldown = 300
#   }
# }