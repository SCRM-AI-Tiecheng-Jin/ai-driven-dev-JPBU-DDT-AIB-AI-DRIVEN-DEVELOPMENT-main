output "bucket_name" {
  description = "Name of the production S3 bucket."
  value       = module.production_s3_bucket.bucket_name
}

output "bucket_arn" {
  description = "ARN of the production S3 bucket."
  value       = module.production_s3_bucket.arn
}

output "bucket_region" {
  description = "AWS region where the production S3 bucket is deployed."
  value       = module.production_s3_bucket.region
}

output "bucket_regional_domain_name" {
  description = "Regional DNS domain name for the production S3 bucket."
  value       = module.production_s3_bucket.regional_domain
}

output "access_log_bucket" {
  description = "Centralized access log bucket receiving server access logs."
  value       = module.production_s3_bucket.access_log_bucket
}
