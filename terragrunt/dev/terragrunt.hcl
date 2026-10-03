locals {

}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket = "gjafar-dev-terraform-state"
    key    = "${path_relative_to_include()}/terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "terraform-state-lock-table"
  }
}

generate "provider" {
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "aws" {
  region = "eu-west-1"
}
EOF
  path     = "provider.tf"
}