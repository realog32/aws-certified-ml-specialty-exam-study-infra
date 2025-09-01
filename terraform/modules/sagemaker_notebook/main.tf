resource "aws_sagemaker_notebook_instance" "this" {
  name                  = var.name
  role_arn              = var.role_arn
  instance_type         = var.instance_type
  volume_size           = var.volume_size

  subnet_id             = var.subnet_id
  security_groups       = var.security_group_ids

  tags = var.tags
}

output "notebook_name" {
  value       = aws_sagemaker_notebook_instance.this.name
  description = "Notebook instance name"
}
