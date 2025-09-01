output "role_arn" {
  value       = aws_iam_role.sagemaker_execution.arn
  description = "SageMaker execution role ARN"
}
