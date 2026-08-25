# Production S3 Bucket

Terraform configuration for a production AWS S3 bucket using the approved Takeda `S3` building block.

## What this deploys

- S3 bucket named by Takeda standards through `app.terraform.io/Takeda/S3/aws`
- SSE-KMS encryption with the Takeda-managed `alias/TEC-S3` key by default
- S3 Bucket Keys enabled for KMS cost optimization
- Versioning enabled for production data protection
- Server access logging enabled for auditability
- Default Takeda lifecycle policies and Intelligent-Tiering enabled
- Public access protections inherited from the Takeda S3 module

## Prerequisites

- Terraform `>= 1.6.0`
- AWS provider `~> 6.35`
- AWS credentials supplied by the Takeda Terraform Cloud workflow
- Mandatory Takeda shared tags supplied through workspace variables or `.auto.tfvars`

## Example variables

Create a local `production.auto.tfvars` for testing only. Do not commit `.tfvars` files.

```hcl
primary_region         = "ap-northeast-1"
bucket_purpose        = "production-data"
terraform_workspace   = "tec-cpm-caz-prd-12345-AIDrivenDevelopment"
user_preferred_index  = 1

shared_tags = {
  "apms-id"            = "APMS-12345"
  "application-name"   = "AI Driven Development"
  "application-owner"  = "owner@takeda.com"
  "asec-tier"          = "at"
  "environment-id"     = "prod"
  "is-multi-tenant"    = "False"
  "it-technical-owner" = "technical.owner@takeda.com"
  "ops-exclude-patch"  = "S1"
  "recovery-tier"      = "Tier 3"
  "service-ci-id"      = "BSN1234567"
  "version"            = "2022-03-30"
}
```

## Takeda IaC Pipeline

Takeda uses a VCS-driven workflow connected to the `oneTakeda` GitHub repository. Plan and apply operations are executed in Terraform Cloud, not from local developer machines.

Refer to the Takeda IaC Pipeline documentation for complete pipeline details and best practices: https://onetakeda.atlassian.net/wiki/spaces/AIDEDOC/pages/5816975566/New+TFC+Project+IaC+Pipeline

## Validation

Recommended local checks:

```bash
terraform init -backend=false
terraform validate
tflint
terraform test
checkov -d . --framework terraform
```
