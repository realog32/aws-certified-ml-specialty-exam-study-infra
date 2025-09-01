variable "name" {
  description = "Name of the notebook instance"
  type        = string
}

variable "role_arn" {
  description = "SageMaker execution role ARN"
  type        = string
}

variable "instance_type" {
  description = "Notebook instance type"
  type        = string
}

variable "volume_size" {
  description = "EBS volume size in GiB"
  type        = number
}

variable "subnet_id" {
  description = "Subnet ID (optional)"
  type        = string
  default     = null
}

variable "security_group_ids" {
  description = "Security group IDs (optional)"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
