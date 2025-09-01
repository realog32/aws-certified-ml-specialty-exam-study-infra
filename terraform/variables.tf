variable "aws_region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "AWS profile name from local credentials file. Leave null to use environment vars."
  type        = string
  default     = null
}

variable "environment" {
  description = "Environment name tag (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
  default     = "aws-mls-prep"
}

variable "create_notebook" {
  description = "Whether to create a SageMaker notebook instance"
  type        = bool
  default     = false
}

variable "bucket_name" {
  description = "Optional explicit S3 bucket name (must be globally unique). If null, a unique name will be generated."
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "Allow Terraform to delete S3 bucket with non-empty contents"
  type        = bool
  default     = false
}

variable "notebook_instance_type" {
  description = "Instance type for SageMaker notebook"
  type        = string
  default     = "ml.t3.medium"
}

variable "notebook_volume_size" {
  description = "EBS volume size (GiB) for SageMaker notebook"
  type        = number
  default     = 10
}

variable "notebook_subnet_id" {
  description = "Subnet ID for SageMaker notebook (optional, for VPC)"
  type        = string
  default     = null
}

variable "notebook_security_group_ids" {
  description = "Security group IDs for SageMaker notebook (optional, for VPC)"
  type        = list(string)
  default     = []
}
