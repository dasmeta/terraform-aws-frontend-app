module "waf" {
  source  = "dasmeta/modules/aws//modules/waf"
  version = "2.15.6"

  count = try(var.waf.enabled, false) ? 1 : 0

  name = try(var.waf.name, "${replace(var.domain, "/[\\W|_|\\s]+/", "-")}-firewall")

  scope                  = try(var.waf.scope, "CLOUDFRONT")
  visibility_config      = try(var.waf.visibility_config, { cloudwatch_metrics_enabled = false, sampled_requests_enabled = true })
  rules                  = try(var.waf.rules, [])
  create_alb_association = try(var.waf.create_alb_association, false)
  alb_arn_list           = try(var.waf.alb_arn_list, [])
  allow_default_action   = try(var.waf.allow_default_action, true)
  whitelist_ips          = try(var.waf.whitelist_ips, [])
  enable_whitelist       = try(var.waf.enable_whitelist, true)
  alarms                 = try(var.waf.alarms, true)

  providers = {
    // TODO: for cloudfront distribution the waf gets created in virginia, but for alb the specific region should be used,
    // needs to decide how to accomplish this
    aws = aws.virginia
  }
}
