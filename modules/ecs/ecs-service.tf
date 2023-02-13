# resource "aws_ecs_service" "ecs_service" {
#   name                               = "${var.appname_prefix}-${var.ecs_scope}"
#   cluster                            = aws_ecs_cluster.ecs_cluster.id
#   task_definition                    = var.ecs_task_definition_arn
#   desired_count                      = var.service_desired_count
#   force_new_deployment               = true
#   deployment_minimum_healthy_percent = 100
#   deployment_maximum_percent         = 200
#   health_check_grace_period_seconds  = length(var.target_group_arn) > 0 ? 120 : null
#   platform_version                   = var.platform_version
#   launch_type                        = "FARGATE"
#   scheduling_strategy                = var.scheduling_strategy
#   enable_execute_command             = true
#   deployment_controller {
#     type = "ECS"
#   }


#   network_configuration {
#     security_groups  = [aws_security_group.ecs_tasks.id]
#     subnets          = var.private_subnets
#     assign_public_ip = false
#   }

#   dynamic "load_balancer" {
#     for_each = length(var.target_group_arn) > 0 ? [var.target_group_arn] : []
#     content {
#       container_name   = "${var.appname_prefix}-${var.ecs_scope}-${var.container_suffix}"
#       target_group_arn = var.target_group_arn
#       container_port   = var.container_port
#     }
#   }