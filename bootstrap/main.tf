terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.36.0"
    }
  }
}
provider "aws" {
  region = var.region
}

//Save actual state in S3 bucket and use DynamoDB table for state locking
resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "gjafar-${var.env}-terraform-state"

  tags = {
    Name        = var.tag_name
    Environment = var.env
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "terraform-state-lock-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = var.tag_name
    Environment = var.env
  }
}

/*
List all the resources in the AWS account with the tag Name=aws-terraform-mini. This is useful to check if the resources have been created successfully.
aws resourcegroupstaggingapi get-resources \
  --tag-filters Key=Name,Values=aws-terraform-mini \
  --query "ResourceTagMappingList[].ResourceARN" \
  --output table
 */