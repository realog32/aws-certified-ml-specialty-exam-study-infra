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
  tags   = local.common_tags
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

resource "local_file" "connection_info" {
  filename = "${path.root}/terraform_local_info.json"
  content  = jsonencode({
    region             = var.aws_region
    bucket_name        = module.s3_data_bucket.bucket_name
    sagemaker_role_arn = module.sagemaker_iam.role_arn
    notebook_name      = var.create_notebook ? module.sagemaker_notebook[0].notebook_name : null
    vpc_id             = module.vpc.vpc_id
    private_subnets    = module.vpc.private_subnet_ids
  })
  file_permission = "0644"
}
