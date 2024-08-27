module "this" {
  source = "../../"

  domain              = "basic-test-front-app.devops.dasmeta.com"
  zone                = "devops.dasmeta.com"
  alternative_domains = ["basic-test-front-app-1.devops.dasmeta.com"]
  alternative_zones   = ["devops.dasmeta.com"]

  providers = { aws : aws, aws.virginia : aws.virginia }
}
