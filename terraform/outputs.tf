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

output "prediction_user_name" {
  value       = module.sagemaker_iam.prediction_user_name
  description = "IAM user name for prediction-only access (if created)"
}

output "prediction_user_arn" {
  value       = module.sagemaker_iam.prediction_user_arn
  description = "IAM user ARN for prediction-only access (if created)"
}

output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "VPC ID"
}

output "private_subnet_ids" {
  value       = module.vpc.private_subnet_ids
  description = "Private subnet IDs for workloads and SageMaker"
}

output "sagemaker_domain_id" {
  value       = var.create_sagemaker_domain ? module.sagemaker_app[0].domain_id : null
  description = "SageMaker Domain ID"
}

output "sagemaker_domain_user_profile" {
  value       = var.create_sagemaker_domain ? module.sagemaker_app[0].user_profile_name : null
  description = "Default user profile name in the Domain"
}