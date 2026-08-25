run "production_defaults" {
  command = plan

  variables {
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
  }

  assert {
    condition     = var.primary_region == "ap-northeast-1"
    error_message = "Default region should be ap-northeast-1."
  }

  assert {
    condition     = var.bucket_purpose == "production-data"
    error_message = "Default bucket purpose should describe production data usage."
  }

  assert {
    condition     = var.bucket_key_alias == "alias/TEC-S3"
    error_message = "Default encryption key should use the Takeda-managed S3 KMS key."
  }
}
