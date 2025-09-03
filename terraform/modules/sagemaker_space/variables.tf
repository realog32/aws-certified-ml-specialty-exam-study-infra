variable "name" {
  description = "SageMaker Space name"
  type        = string
}

variable "code_repository_url" {
  description = "Default code repository URL (optional)"
  type        = string
}

variable "domain_id" {
  description = "SageMaker Domain ID"
  type        = string
}

variable "owner_user_profile_name" {
  description = "User profile that owns the space"
  type        = string
}

variable "instance_type" {
  description = "Default instance type for the JupyterLab space"
  type        = string
  default     = "ml.t3.medium"
}

variable "lifecycle_config_arn" {
  description = "Optional Studio lifecycle config ARN"
  type        = string
  default     = null
}

variable "sharing_type" {
  description = "Space sharing type: Private or Shared"
  type        = string
  default     = "Private"
}

variable "tags" {
  description = "Tags to apply to the space"
  type        = map(string)
  default     = {}
}


