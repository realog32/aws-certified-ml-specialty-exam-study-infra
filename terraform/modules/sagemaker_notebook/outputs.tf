output "notebook_name" {
  value       = aws_sagemaker_notebook_instance.this.name
  description = "Notebook instance name"
}
