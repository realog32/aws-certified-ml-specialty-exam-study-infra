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

# Prediction-only policy allowing SageMaker read actions and endpoint invocation
data "aws_iam_policy_document" "sagemaker_invoke_endpoint" {
  statement {
    effect = "Allow"
    actions = [
      "sagemaker:Describe*",
      "sagemaker:List*",
      "sagemaker:Get*",
      "sagemaker:InvokeEndpoint",
      "sagemaker:InvokeEndpointAsync"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "sagemaker_invoke_endpoint" {
  name        = "SageMakerInvokeEndpoint"
  description = "Prediction-only policy: SageMaker read actions and InvokeEndpoint"
  policy      = data.aws_iam_policy_document.sagemaker_invoke_endpoint.json
  tags        = var.tags
}

resource "aws_iam_user" "prediction" {
  count = var.create_prediction_user ? 1 : 0
  name  = var.prediction_username
  tags  = var.tags
}

resource "aws_iam_user_policy_attachment" "prediction_invoke" {
  count      = var.create_prediction_user ? 1 : 0
  user       = aws_iam_user.prediction[0].name
  policy_arn = aws_iam_policy.sagemaker_invoke_endpoint.arn
}

resource "aws_iam_user_policy_attachment" "prediction_s3_readonly" {
  count      = var.create_prediction_user ? 1 : 0
  user       = aws_iam_user.prediction[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}