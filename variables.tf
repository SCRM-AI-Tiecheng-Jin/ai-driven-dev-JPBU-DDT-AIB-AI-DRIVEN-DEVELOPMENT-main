variable "primary_region" {
  type        = string
  description = "Primary TEC-approved AWS region for the production S3 bucket."
  default     = "ap-northeast-1"

  validation {
    condition = contains([
      "us-east-1",
      "us-west-2",
      "ap-northeast-1",
      "ap-southeast-1",
      "ap-southeast-3",
      "eu-central-1",
      "eu-west-1"
    ], var.primary_region)
    error_message = "primary_region must be a TEC-approved AWS region."
  }
}

variable "bucket_purpose" {
  type        = string
  description = "Lowercase kebab-case purpose used by the Takeda S3 module to generate the bucket name."
  default     = "production-data"

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,38}[a-z0-9]$", var.bucket_purpose))
    error_message = "bucket_purpose must be 3-40 characters of lowercase letters, numbers, and hyphens, and must start/end with an alphanumeric character."
  }
}

variable "bucket_key_alias" {
  type        = string
  description = "KMS key alias or ID used for S3 SSE-KMS encryption. Defaults to the Takeda-managed S3 key."
  default     = "alias/TEC-S3"

  validation {
    condition     = length(trimspace(var.bucket_key_alias)) > 0
    error_message = "bucket_key_alias must not be empty."
  }
}

variable "user_preferred_index" {
  type        = number
  description = "Numeric suffix used by the Takeda S3 module to avoid bucket name collisions."
  default     = 1

  validation {
    condition     = var.user_preferred_index >= 1 && var.user_preferred_index <= 99 && floor(var.user_preferred_index) == var.user_preferred_index
    error_message = "user_preferred_index must be an integer between 1 and 99."
  }
}

variable "terraform_workspace" {
  type        = string
  description = "Terraform Cloud workspace name used by Takeda modules for naming and tag validation."
  default     = ""
}

variable "shared_tags" {
  type        = map(string)
  description = "Mandatory Takeda shared tags applied to S3 resources."

  validation {
    condition = alltrue([
      for key in [
        "apms-id",
        "application-name",
        "application-owner",
        "asec-tier",
        "environment-id",
        "is-multi-tenant",
        "it-technical-owner",
        "ops-exclude-patch",
        "recovery-tier",
        "service-ci-id",
        "version"
      ] : length(trimspace(lookup(var.shared_tags, key, ""))) > 0
    ])
    error_message = "shared_tags must include all mandatory Takeda tagging keys with non-empty values."
  }
}
