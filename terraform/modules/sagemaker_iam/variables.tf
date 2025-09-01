variable "name_prefix" {
  description = "Prefix for SageMaker IAM role name"
  type        = string
  default     = "mls-prep"
}

variable "tags" {
  description = "Tags to apply to SageMaker resources"
  type        = map(string)
  default     = {}
}
