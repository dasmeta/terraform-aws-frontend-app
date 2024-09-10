variable "domain" {
  type        = string
  description = "domain full name"
}

variable "alternative_domains" {
  type    = list(string)
  default = []
}

variable "alternative_zones" {
  type    = list(string)
  default = []
}

variable "enable_http_security_headers" {
  type        = bool
  default     = false
  description = "Whether to enable http security headers by creating pass through lambda handler for cdn"
}

variable "zone" {
  type        = string
  default     = null
  description = "R53 zone name"
}

variable "waf" {
  type        = any
  default     = null
  description = "waf configs"
}

variable "s3_configs" {
  type = object({
    acl                     = optional(string, "private")
    create_index_html       = optional(bool, true)
    ignore_public_acls      = optional(bool, true)
    restrict_public_buckets = optional(bool, true)
    block_public_acls       = optional(bool, true)
    block_public_policy     = optional(bool, true)

    versioning      = optional(object({ enabled = bool }), { enabled = false })
    website         = optional(object({ index_document = string, error_document = string }), { index_document = "index.html", error_document = "index.html" })
    create_iam_user = optional(bool, false)
    cors_rule       = optional(list(any),[])
  })
  default = {
    acl                     = "private"
    create_index_html       = true
    ignore_public_acls      = true
    restrict_public_buckets = true
    block_public_acls       = true
    block_public_policy     = true
    versioning = {
      enabled = false
    }
    website = {
      index_document = "index.html"
      error_document = "index.html"
    }
    create_iam_user = false
    cors_rule       = []
  }
  description = "S3 bucket configuration options"
}

variable "cdn_configs" {
  type = object({
    default_root_object = optional(string, "index.html")
    additional_origins  = optional(any, [])
  })
  default = {
    default_root_object = "index.html"
    additional_origins  = []
  }
  description = "CDN configuration options"
}
