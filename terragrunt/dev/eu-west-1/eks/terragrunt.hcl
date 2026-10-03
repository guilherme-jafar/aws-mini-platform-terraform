locals {
  env = "dev"
}

include "root" {
  path = find_in_parent_folders()
}

include "common" {
  path = "${get_path_to_repo_root()}/terragrunt/_envcommon/common.hcl"
  expose = true
}

terraform {
  source = "${get_path_to_repo_root()}/modules/eks"
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    vpc_id = "vpc-00000000"
    private_subnets = ["subnet-00000000", "subnet-00000001"]
  }
}

inputs = {
  //eks Cluster configuration
  cluster_name                = "eks-${include.common.locals.project_name}-${local.env}"
  cluster_authentication_mode = "API"
  cluster_version             = "1.35"

  //eks node groups configuration
  node_group_name             = "node-group-${include.common.locals.project_name}-${local.env}"
  node_group_scaling = {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
  node_group_max_unavailable = 1

  //roles configuration for both eks and node group
  eks_role_name              = "eks-role-${include.common.locals.project_name}-${local.env}"
  node_role_name             = "node-group-role-${include.common.locals.project_name}-${local.env}"
  admin_principal_arn        = include.common.locals.admin_principal_arn

  subnet_ids                 = dependency.vpc.outputs.private_subnets

  tag_name                   = include.common.locals.tag_name
  tag_env                    = local.env

}