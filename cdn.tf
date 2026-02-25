
locals {
  s3_origin_base = [{
    id          = "s3"
    domain_name = module.s3.s3_bucket_id
    type        = "bucket"
    behavior    = try(var.cdn_configs.s3_behavior, {})
  }]

  cdn_origins = var.cdn_configs.s3_is_default_origin ? concat(
    var.cdn_configs.additional_origins,
    local.s3_origin_base
    ) : concat(
    local.s3_origin_base,
    var.cdn_configs.additional_origins
  )
}

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

  origins = local.cdn_origins

  providers = {
    aws          = aws
    aws.virginia = aws.virginia
  }
}
