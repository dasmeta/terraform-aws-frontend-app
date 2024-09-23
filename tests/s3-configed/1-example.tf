module "this" {
  source = "../../"

  domain              = "basic-test-front-app.devops.dasmeta.com"
  zone                = "devops.dasmeta.com"
  alternative_domains = ["basic-test-front-app-1.devops.dasmeta.com"]
  alternative_zones   = ["devops.dasmeta.com"]

  s3_configs = {
    cors_rule = [
      {
        allowed_methods = ["HEAD", "GET", "PUT", "POST"]
        allowed_origins = ["https://modules.tf", "https://dasmeta.modules.tf"]
        allowed_headers = ["*"]
        expose_headers  = ["ETag", "Access-Control-Allow-Origin"]
      }
    ]
    event-notification-config = {
      target_type   = "sqs"
      queue_name    = "test"
      filter_prefix = "test/"
      events        = ["s3:ObjectCreated:*"]
    }
  }

  providers = { aws : aws, aws.virginia : aws.virginia }
}
