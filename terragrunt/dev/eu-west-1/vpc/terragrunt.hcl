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
  source = "${include.common.locals.source_vpc_base_url}?version=${include.common.locals.vpc_version}"
}

inputs = {
  name = "vpc-${include.common.locals.project_name}-${local.env}"

  azs  = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_dns_hostnames = true
  enable_nat_gateway   = true
  single_nat_gateway = true

  tags = {
    Name        = include.common.locals.tag_name
    Environment = "dev"
  }
}