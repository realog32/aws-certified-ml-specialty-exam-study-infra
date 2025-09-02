provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "terraform"
      Repo        = "github.com/realog32/aws-certified-ml-specialty-exam-study-infra"
    }
  }
}
