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

variable "create_prediction_user" {
  description = "Whether to create an IAM user for prediction-only access"
  type        = bool
  default     = true
}

variable "prediction_username" {
  description = "IAM username for prediction-only access"
  type        = string
  default     = "ml_user_predict"
}