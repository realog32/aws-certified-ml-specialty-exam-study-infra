output "role_arn" {
  value       = aws_iam_role.sagemaker_execution.arn
  description = "SageMaker execution role ARN"
}

output "prediction_policy_arn" {
  value       = aws_iam_policy.sagemaker_invoke_endpoint.arn
  description = "IAM policy ARN for prediction-only SageMaker access"
}

output "prediction_user_name" {
  value       = try(aws_iam_user.prediction[0].name, null)
  description = "IAM user name for prediction-only access (if created)"
}

output "prediction_user_arn" {
  value       = try(aws_iam_user.prediction[0].arn, null)
  description = "IAM user ARN for prediction-only access (if created)"
}