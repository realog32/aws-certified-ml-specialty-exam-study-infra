resource "aws_sagemaker_domain" "this" {
  domain_name               = var.name
  auth_mode                 = var.auth_mode
  vpc_id                    = var.vpc_id
  subnet_ids                = var.subnet_ids
  app_network_access_type   = "VpcOnly"
  tags                      = merge(var.tags, { Name = var.name })

  default_user_settings {
    execution_role = var.execution_role_arn
  }
}

resource "aws_sagemaker_user_profile" "this" {
  domain_id         = aws_sagemaker_domain.this.id
  user_profile_name = var.user_profile_name

  user_settings {
    execution_role = var.execution_role_arn
  }
  tags = var.tags
}

resource "aws_sagemaker_app" "studio" {
  count             = var.create_studio_app ? 1 : 0
  app_name          = var.app_name
  app_type          = var.app_type
  domain_id         = aws_sagemaker_domain.this.id
  user_profile_name = aws_sagemaker_user_profile.this.user_profile_name
  tags              = var.tags
}


