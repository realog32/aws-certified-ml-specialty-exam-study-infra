# AWS Machine Learning Environment Automation

Minimal Terraform project to provision AWS and local resources for running machine learning workloads using SageMaker AI.

## What this creates

- VPC and networking (default: 2 AZs, cost‑optimized)
  - VPC with DNS support (`10.0.0.0/16` by default)
  - Public and private subnets across N AZs (default 2)
  - Internet Gateway, route tables, and associations
  - NAT Gateway(s) with Elastic IPs (default: single NAT for cost savings)

- S3 data bucket (secure by default)
  - Versioning enabled, SSE-S3 (AES256), public access blocked
  - Optional `force_destroy` for teardown safety (default: `false`)
  - Creates a sample project prefix: `<initial_project_name>/`
    - Subfolders: `training/`, `validation/`, `test/`, `model/`, `checkpoints/`, and `output/`

- SageMaker IAM
  - Execution role for SageMaker with managed policies:
    - `AmazonSageMakerFullAccess`, `AmazonS3FullAccess`
  - Optional prediction-only IAM user (default: created) with:
    - Custom InvokeEndpoint read policy and `AmazonS3ReadOnlyAccess`

- SageMaker Studio Domain (default: created)
  - Domain with default user profile
  - Default Studio app (`JupyterServer`) for the user profile

- SageMaker JupyterLab Space (default: created when Domain is enabled)
  - JupyterLab Space with default instance type and optional code repo

- Optional SageMaker Notebook Instance (default: off)
  - Instance type and volume size configurable
  - Can attach to the created VPC/subnets and security groups

- Local helper file
  - `terraform_local_info.json` with: region, bucket name, SageMaker role ARN, notebook name (if any), VPC ID, private subnets, Domain ID/user, Space name

Note on costs: NAT Gateway, Studio Domain/Apps/Spaces, and Notebook Instances may incur charges. Use `terraform destroy` when done and consider leaving `force_destroy = false` unless you understand the implications.

## Prerequisites

- Terraform >= 1.5
- AWS account and credentials
  - Either set `aws_profile` in `terraform.tfvars` to a profile in `~/.aws/credentials`
  - Or export `AWS_PROFILE`/`AWS_ACCESS_KEY_ID`/`AWS_SECRET_ACCESS_KEY` environment variables
- Optional: AWS CLI installed and configured (helps verify auth and browse outputs)

## Usage

1) Initialize Terraform

```bash
cd terraform
terraform init
```

2) Create your `terraform.tfvars` (optional but recommended)

Windows PowerShell:
```powershell
Copy-Item terraform.tfvars.example terraform.tfvars
```
macOS/Linux (bash):
```bash
cp terraform.tfvars.example terraform.tfvars
```
Then edit `terraform.tfvars` to adjust variables (see Variables below).

3) Choose how to authenticate

- Option A: In `terraform.tfvars`, set `aws_profile = "<your_profile>"`
- Option B: Export environment variable before running commands:
```bash
export AWS_PROFILE=<your_profile>
```

4) Plan and apply

```bash
terraform plan
terraform apply
```

After apply, a local file `terraform_local_info.json` is generated with region, bucket, role ARN, VPC details, and (if enabled) Domain/User/Space/Notebook for quick access from scripts or notebooks.

## Variables

See `terraform/variables.tf` and `terraform.tfvars.example` for all options. Key toggles and defaults:

- `create_sagemaker_domain` (bool, default `true`): Create SageMaker Studio Domain and default JupyterServer app
- `create_jupyterlab_space` (bool, default `true`): Create a JupyterLab Space within the Domain
- `create_notebook` (bool, default `false`): Create a classic SageMaker Notebook Instance
- `create_prediction_user` (bool, default `true`): Create an IAM user for prediction-only access
- `vpc_single_nat_gateway` (bool, default `true`): Use a single NAT Gateway to reduce cost
- `bucket_name` (string, default `null`): If null, a unique name is generated
- `force_destroy` (bool, default `false`): Allow deleting non-empty S3 bucket
- `initial_project_name` (string, default `"sample-project"`): Root prefix created with sample subfolders
- `space_code_repository_url` (string): Default repo attached to the JupyterLab Space

Networking sizes, instances, and names are configurable; see the file for details.

## Outputs

Major outputs after apply (see `terraform/outputs.tf`):

- `s3_bucket_name`, `s3_bucket_arn`
- `sagemaker_role_arn`
- `notebook_name` (if created)
- `prediction_policy_arn`, `prediction_user_name`, `prediction_user_arn` (if user created)
- `vpc_id`, `private_subnet_ids`
- `sagemaker_domain_id`, `sagemaker_domain_user_profile` (if Domain created)
- `sagemaker_space_name` (if Space created)

## Cleanup

To remove resources:

```bash
terraform destroy
```

If `force_destroy = false`, empty the S3 bucket manually before destroy or set it to `true` if you understand the implications.

## License

MIT – see `LICENSE`.
