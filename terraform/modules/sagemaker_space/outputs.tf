output "space_name" {
  value       = aws_sagemaker_space.this.space_name
  description = "SageMaker Space name"
}

output "space_arn" {
  value       = aws_sagemaker_space.this.arn
  description = "SageMaker Space ARN"
}


