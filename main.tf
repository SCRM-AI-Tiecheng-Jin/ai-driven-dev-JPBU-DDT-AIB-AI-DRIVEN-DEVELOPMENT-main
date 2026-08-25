provider "aws" {
  region = var.primary_region
}

module "production_s3_bucket" {
  #checkov:skip=CKV_TF_1: Takeda private Terraform Cloud registry modules are version-pinned and cannot use VCS commit hashes.
  source  = "app.terraform.io/Takeda/S3/aws"
  version = "~> 5.2"

  purpose              = var.bucket_purpose
  shared_tags          = var.shared_tags
  terraform_workspace  = var.terraform_workspace != "" ? var.terraform_workspace : terraform.workspace
  bucket_versioning    = "Enabled"
  bucket_key_alias     = var.bucket_key_alias
  enable_bucket_key    = true
  enable_access_log    = true
  enable_tiering       = true
  force_destroy        = false
  user_preferred_index = var.user_preferred_index
}
