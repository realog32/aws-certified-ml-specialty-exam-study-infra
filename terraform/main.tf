locals {
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "terraform"
  }
}

module "vpc" {
  source              = "./modules/vpc"
  name                = "${var.project_name}-${var.environment}"
  vpc_cidr            = var.vpc_cidr
  az_count            = var.vpc_az_count
  single_nat_gateway  = var.vpc_single_nat_gateway
  tags                = local.common_tags
}

module "s3_data_bucket" {
  source        = "./modules/s3_data_bucket"
  bucket_name   = var.bucket_name
  force_destroy = var.force_destroy
  tags          = local.common_tags
}

module "sagemaker_iam" {
  source = "./modules/sagemaker_iam"
  tags                     = local.common_tags
  create_prediction_user   = var.create_prediction_user
  prediction_username      = var.prediction_username
}

module "sagemaker_notebook" {
  count              = var.create_notebook ? 1 : 0
  source             = "./modules/sagemaker_notebook"
  name               = "${var.project_name}-notebook-${var.environment}"
  role_arn           = module.sagemaker_iam.role_arn
  instance_type      = var.notebook_instance_type
  volume_size        = var.notebook_volume_size
  subnet_id          = var.notebook_subnet_id != null ? var.notebook_subnet_id : module.vpc.private_subnet_ids[0]
  security_group_ids = var.notebook_security_group_ids
  tags               = local.common_tags
}

module "sagemaker_app" {
  count              = var.create_sagemaker_domain ? 1 : 0
  source             = "./modules/sagemaker_app"
  name               = coalesce(var.sagemaker_domain_name, "${var.project_name}-domain-${var.environment}")
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.private_subnet_ids
  execution_role_arn = module.sagemaker_iam.role_arn
  user_profile_name  = var.sagemaker_user_profile_name
  tags               = local.common_tags
}

module "sagemaker_space" {
  count                    = var.create_sagemaker_domain && var.create_jupyterlab_space ? 1 : 0
  source                   = "./modules/sagemaker_space"
  name                     = "${var.project_name}-space-${var.environment}"
  domain_id                = module.sagemaker_app[0].domain_id
  owner_user_profile_name  = module.sagemaker_app[0].user_profile_name
  instance_type            = var.space_instance_type
  sharing_type             = var.space_sharing_type
  code_repository_url      = var.space_code_repository_url
  tags                     = local.common_tags
}

resource "local_file" "connection_info" {
  filename = "${path.root}/terraform_local_info.json"
  content  = jsonencode({
    region             = var.aws_region
    bucket_name        = module.s3_data_bucket.bucket_name
    sagemaker_role_arn = module.sagemaker_iam.role_arn
    notebook_name      = var.create_notebook ? module.sagemaker_notebook[0].notebook_name : null
    vpc_id             = module.vpc.vpc_id
    private_subnets    = module.vpc.private_subnet_ids
    domain_id          = var.create_sagemaker_domain ? module.sagemaker_app[0].domain_id : null
    domain_user        = var.create_sagemaker_domain ? module.sagemaker_app[0].user_profile_name : null
    space_name         = var.create_sagemaker_domain && var.create_jupyterlab_space ? module.sagemaker_space[0].space_name : null
  })
  file_permission = "0644"
}
