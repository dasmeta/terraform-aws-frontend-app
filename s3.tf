module "s3" {
  source  = "dasmeta/modules/aws//modules/s3"
  version = "0.36.7"

  name                    = var.domain
  acl                     = "private"
  create_index_html       = true
  ignore_public_acls      = false
  restrict_public_buckets = false
  block_public_acls       = false
  block_public_policy     = false

  versioning = {
    enabled = false
  }
  website = {
    index_document = "index.html"
    error_document = "index.html"
  }
  create_iam_user = false
}
