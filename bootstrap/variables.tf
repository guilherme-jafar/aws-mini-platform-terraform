variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "eu-west-1"
}

variable "tag_name" {
  description = "The name tag to assign to resources."
  type        = string
  default     = "aws-terraform-mini"
}

variable "env" {
  description = "The environment."
  type        = string
  default     = "dev"
}
