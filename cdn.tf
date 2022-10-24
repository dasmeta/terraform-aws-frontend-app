
module "cdn" {
  source  = "dasmeta/modules/aws//modules/cloudfront-ssl-hsts"
  version = "1.1.2"

  zone       = concat([var.zone], var.alternative_zones)
  aliases    = concat([var.domain], var.alternative_domains)
  comment    = "cdn for ${var.domain}"
  web_acl_id = try(module.waf[0].web_acl_arn, null)

  origin = {
    s3 = {
      domain_name = module.s3.s3_bucket_website_endpoint
      custom_origin_config = {
        origin_protocol_policy = "http-only"
      }
    }
  }

  default_cache_behavior = {
    target_origin_id     = "s3"
    use_forwarded_values = true
    headers              = []
  }

  providers = {
    aws = aws.virginia
  }
}
