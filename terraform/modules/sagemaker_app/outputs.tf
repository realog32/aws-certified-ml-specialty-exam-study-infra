output "domain_id" {
  value       = aws_sagemaker_domain.this.id
  description = "SageMaker Domain ID"
}

output "domain_arn" {
  value       = aws_sagemaker_domain.this.arn
  description = "SageMaker Domain ARN"
}

output "user_profile_name" {
  value       = aws_sagemaker_user_profile.this.user_profile_name
  description = "Default user profile name"
}


