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

output "s3_config" {
  value = var.s3_configs
}

output "s3_data" {
  value       = module.s3
  sensitive   = true
  description = "The created s3 bucket related output data"
}
