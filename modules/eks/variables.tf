variable "cluster_name" {
  type        = string
  default     = "example"
  description = "The name of the EKS cluster."
}

variable "cluster_authentication_mode" {
  type        = string
  default     = "API"
  description = "The authentication mode for the EKS cluster."
}

variable "cluster_version" {
  type        = string
  default     = "1.35"
  description = "The version of the EKS cluster."
}

variable "admin_principal_arn" {
  type        = string
  description = "The ARN of the IAM user or role to be granted admin access to the EKS cluster."
}

variable "eks_role_name" {
  type        = string
  default     = "eks-auto-node"
  description = "The name of the EKS role."
}

variable "node_role_name" {
  type        = string
  default     = "eks-auto-node"
  description = "The name of the EKS role."
}

variable "node_group_name" {
  type        = string
  default     = "example"
  description = "The name of the EKS node group."
}

variable "node_group_scaling" {
  type = object({
    desired_size = number
    max_size     = number
    min_size     = number
  })
  default = {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
  description = "The scaling configuration for the EKS node group."
}

variable "node_group_max_unavailable" {
  description = "The maximum number of unavailable nodes during a rolling update."
  type        = number
  default     = 1
}

variable "tag_name" {
  description = "The name tag to assign to resources."
  type        = string
  default     = "aws-terraform-mini"
}

variable "tag_env" {
  description = "The environment tag to assign to resources."
  type        = string
  default     = "dev"
}

variable "subnet_ids" {
  description = "The IDs of the subnets."
  type        = list(string)
}

