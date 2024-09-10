module "s3" {
  # source  = "dasmeta/s3/aws"
  # version = "1.2.1"
  source = "git::https://github.com/dasmeta/terraform-aws-s3.git?ref=DMVP-5181"

  name                    = var.domain
  acl                     = var.s3_configs.acl
  create_index_html       = var.s3_configs.create_index_html
  ignore_public_acls      = var.s3_configs.ignore_public_acls
  restrict_public_buckets = var.s3_configs.restrict_public_buckets
  block_public_acls       = var.s3_configs.block_public_acls
  block_public_policy     = var.s3_configs.block_public_policy
  versioning              = var.s3_configs.versioning
  website                 = var.s3_configs.website
  create_iam_user         = var.s3_configs.create_iam_user
  cors_rule               = var.s3_configs.cors_rule
}
