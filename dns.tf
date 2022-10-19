module "dns" {
  source = "../dns"

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
