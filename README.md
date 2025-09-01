# AWS Certified Machine Learning – Specialty: Study Infra

Minimal Terraform project to provision AWS and local resources useful while preparing for the AWS Certified Machine Learning – Specialty exam. Safe-by-default, easy to extend, and suitable for open-source.

## What this creates

- S3 data bucket with versioning, SSE, and public access blocked
- SageMaker execution IAM role with managed policies
- Optional SageMaker notebook instance (off by default)
- Local JSON file with connection info (`terraform_local_info.json`)

## Prerequisites

- Terraform >= 1.5
- AWS account and credentials configured (env vars or `~/.aws/credentials` profile)

## Usage

1) Initialize Terraform

```bash
cd terraform
terraform init
```

2) Optionally create your `terraform.tfvars` based on the example

```bash
copy terraform.tfvars.example terraform.tfvars
# then edit values (Windows PowerShell: `Copy-Item`)
```

3) Plan and apply

```bash
terraform plan
terraform apply
```

Outputs include the bucket name and role ARN. A local file `terraform_local_info.json` will be generated for quick access from scripts or notebooks.

## Variables

See `terraform/variables.tf` and `terraform.tfvars.example` for available settings, including toggling the SageMaker notebook with `create_notebook`.

## Cleanup

To remove resources:

```bash
terraform destroy
```

If `force_destroy = false`, empty the S3 bucket manually before destroy or set it to `true` if you understand the implications.

## License

MIT – see `LICENSE`.
