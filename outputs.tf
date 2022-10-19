output "s3_bucket_id" {
  value       = module.s3.s3_bucket_id
  description = "s3 bucket name/id"
}

output "distribution_id" {
  value       = module.cdn.cloudfront_distribution_id
  description = "cloudfront distribution id"
}

output "web_acl_id" {
  value       = try(module.waf[0].web_acl_id, null)
  description = "waf arm/id"
}
