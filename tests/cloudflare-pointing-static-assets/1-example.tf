module "this" {
  source = "../../"

  domain               = "test.assets.devops.dasmeta.com"
  certificate_validate = false # NOTE: at first run it will fail to create cloudflare distribution as certificate needs to be validated manually in cloudflare by creating the needed CNAME record(check/get dns record in aws cert manager)


  s3_configs = {
    create_iam_user = true
    lifecycle_rules = [
      {
        id      = "cleanup-objects-after-1-month"
        enabled = true
        expiration = {
          days = 30
        }
        filter = {
          object_size_greater_than = 0
        }
      }
    ]
  }

  providers = { aws : aws, aws.virginia : aws.virginia }
}
