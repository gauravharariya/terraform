# Create aws ecs cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${var.naming}-ecscluster"

   tags = {
    Name = "${var.naming}-ecscluster"
    ENV  = var.env
  }
  
}