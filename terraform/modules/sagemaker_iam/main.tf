data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_iam_role" "sagemaker_execution" {
  name               = "${var.name_prefix}-sagemaker-exec-role"
  assume_role_policy = data.aws_iam_policy_document.sagemaker_assume_role.json
  tags               = var.tags
}

data "aws_iam_policy_document" "sagemaker_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["sagemaker.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy_attachment" "basic" {
  role       = aws_iam_role.sagemaker_execution.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
}

resource "aws_iam_role_policy_attachment" "s3_access" {
  role       = aws_iam_role.sagemaker_execution.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

output "role_arn" {
  value       = aws_iam_role.sagemaker_execution.arn
  description = "SageMaker execution role ARN"
}
