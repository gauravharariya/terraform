include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_path_to_repo_root()}//modules/networking"
}


inputs = {
  env                  = "dev"
  cidr_block           = "10.0.0.0/20"
  private_subnet1_cidr = "10.0.0.0/22"
  private_subnet2_cidr = "10.0.4.0/22"
  public_subnet1_cidr  = "10.0.8.0/24"
  public_subnet2_cidr  = "10.0.9.0/24"
  db_subnet1_cidr      = "10.0.10.0/24"
  db_subnet2_cidr      = "10.0.11.0/24"
  
endpoint_sg_rules = {
    "For All - Ingress - Self VPC" = {
      "type" : "ingress",
      "to_port" : "65535",
      "from_port" : "0",
      "cidr_blocks" : ["10.68.32.0/22"],
      "protocol" : "TCP"
    },
    "For SSH - Ingress - VPC" = {
      "type" : "ingress",
      "to_port" : "22",
      "from_port" : "22",
      "cidr_blocks" : ["0.0.0.0/0"],
      "protocol" : "TCP"
    },
    "For All - Egress" = {
      "type" : "egress",
      "to_port" : "65535",
      "from_port" : "0",
      "cidr_blocks" : ["0.0.0.0/0"],
      "protocol" : "All"
    }
  }
}