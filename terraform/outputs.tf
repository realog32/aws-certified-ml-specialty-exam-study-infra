output "s3_bucket_name" {
  value       = module.s3_data_bucket.bucket_name
  description = "Name of the S3 data bucket"
}

output "s3_bucket_arn" {
  value       = module.s3_data_bucket.bucket_arn
  description = "ARN of the S3 data bucket"
}

output "sagemaker_role_arn" {
  value       = module.sagemaker_iam.role_arn
  description = "IAM role ARN for SageMaker"
}

output "notebook_name" {
  value       = var.create_notebook ? module.sagemaker_notebook[0].notebook_name : null
  description = "Name of the SageMaker notebook instance (if created)"
}

output "prediction_policy_arn" {
  value       = module.sagemaker_iam.prediction_policy_arn
  description = "IAM policy ARN for prediction-only SageMaker access"
}