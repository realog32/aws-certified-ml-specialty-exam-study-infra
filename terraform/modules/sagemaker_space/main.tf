resource "aws_sagemaker_space" "this" {
  domain_id  = var.domain_id
  space_name = var.name

  space_settings {
    app_type = "JupyterLab"

    jupyter_lab_app_settings {

      code_repository {
        repository_url  = var.code_repository_url
      }

      default_resource_spec {
        instance_type        = var.instance_type
        lifecycle_config_arn = var.lifecycle_config_arn
      }
    }
  }

  ownership_settings {
    owner_user_profile_name = var.owner_user_profile_name
  }

  space_sharing_settings {
    sharing_type = var.sharing_type
  }

  tags = var.tags
}


