module "dns" {
  source  = "dasmeta/dns/aws"
  version = "1.0.4"

  count = var.zone == null ? 0 : 1

  zone        = var.zone
  create_zone = false

  records = [
    {
      target_type     = "cdn"
      name            = replace(var.domain, var.zone, "")
      distribution_id = module.cdn.cloudfront_distribution_id
    }
  ]
}

module "dns_alternative" {
  source  = "dasmeta/dns/aws"
  version = "1.0.4"

  for_each = { for key, domain in var.alternative_domains : domain => {
    domain : domain
    key : key
    zone : try(var.alternative_zones[key], var.zone)
  } }

  zone        = each.value.zone
  create_zone = false

  records = [
    {
      target_type     = "cdn"
      name            = replace(each.value.domain, each.value.zone, "")
      distribution_id = module.cdn.cloudfront_distribution_id
    }
  ]
}
