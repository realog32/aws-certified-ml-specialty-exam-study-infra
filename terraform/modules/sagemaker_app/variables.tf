variable "name" {
  description = "SageMaker Domain name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for SageMaker Domain"
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs for Domain networking"
  type        = list(string)
}

variable "execution_role_arn" {
  description = "IAM execution role ARN for SageMaker"
  type        = string
}

variable "auth_mode" {
  description = "Authentication mode for the Domain"
  type        = string
  default     = "IAM"
}

variable "user_profile_name" {
  description = "Default user profile name"
  type        = string
  default     = "aws-mls-prep"
}

variable "create_studio_app" {
  description = "Whether to create a default Studio app"
  type        = bool
  default     = true
}

variable "app_name" {
  description = "Studio app name"
  type        = string
  default     = "studio"
}

variable "app_type" {
  description = "Studio app type"
  type        = string
  default     = "JupyterServer"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}


