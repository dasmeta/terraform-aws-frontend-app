
module "cdn" {
  source  = "dasmeta/modules/aws//modules/cloudfront-ssl-hsts"
  version = "2.18.8"

  zone                 = concat([var.zone], var.alternative_zones)
  aliases              = concat([var.domain], var.alternative_domains)
  comment              = "cdn for ${var.domain}"
  web_acl_id           = try(module.waf[0].web_acl_arn, null)
  create_hsts          = var.enable_http_security_headers
  default_root_object  = var.cdn_configs.default_root_object
  certificate_validate = var.certificate_validate

  origins = concat(
    var.cdn_configs.additional_origins,
    [
      {
        id          = "s3" # the last one is default origin/behavior, we suppose the front app is default one
        domain_name = module.s3.s3_bucket_id
        type        = "bucket"
      }
    ]
  )

  providers = {
    aws          = aws
    aws.virginia = aws.virginia
  }
}
