run "missing_required_tag_rejected" {
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
      "version"            = "2022-03-30"
    }
  }

  expect_failures = [
    var.shared_tags
  ]
}
