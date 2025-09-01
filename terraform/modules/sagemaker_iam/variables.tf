variable "name_prefix" {
  description = "Prefix for IAM role name"
  type        = string
  default     = "mls-prep"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
