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

variable "vpc_cidr" {
  description = "CIDR for the VPC to host SageMaker"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_az_count" {
  description = "Number of AZs to spread subnets across"
  type        = number
  default     = 2
}

variable "vpc_single_nat_gateway" {
  description = "Use a single NAT Gateway (cost saver)"
  type        = bool
  default     = true
}

variable "create_sagemaker_domain" {
  description = "Whether to create a SageMaker Domain and default app"
  type        = bool
  default     = true
}

variable "sagemaker_domain_name" {
  description = "Name for the SageMaker Domain"
  type        = string
  default     = null
}

variable "sagemaker_user_profile_name" {
  description = "Default user profile name in the Domain"
  type        = string
  default     = "studio-user"
}