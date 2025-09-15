variable "bucket_name" {
  description = "Optional explicit bucket name"
  type        = string
  default     = null
}

variable "project_name" {
  description = "Project name (for default bucket naming)"
  type        = string
  default     = "aws-mls-prep"
}

variable "environment" {
  description = "Environment (for default bucket naming)"
  type        = string
  default     = "dev"
}

variable "force_destroy" {
  description = "Allow bucket deletion even if not empty"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "initial_project_name" {
  description = "Root prefix/folder to create in the S3 bucket for sample projects"
  type        = string
  default     = "sample-project"
}