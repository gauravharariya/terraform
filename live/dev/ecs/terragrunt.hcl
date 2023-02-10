include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_path_to_repo_root()}//modules/ecs"
}

dependency "vpc" {
  config_path = find_in_parent_folders("networking")

#   mock_outputs = {
#     aws_private_subnet_1_id       = "temporary-dummy-id-1"
#     aws_private_subnet_2_id       = "temporary-dummy-id-2"
#     aws_security_group_default_id = "temporary-security-group-dummy-id"
#   }
}


inputs = {
 env              = "dev"
redis_subnet_ids = [
    dependency.vpc.outputs.vp_id
  ]
}
