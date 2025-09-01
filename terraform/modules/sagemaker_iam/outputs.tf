output "role_arn" {
  value       = aws_iam_role.sagemaker_execution.arn
  description = "SageMaker execution role ARN"
}

output "prediction_policy_arn" {
  value       = aws_iam_policy.sagemaker_invoke_endpoint.arn
  description = "IAM policy ARN for prediction-only SageMaker access"
}