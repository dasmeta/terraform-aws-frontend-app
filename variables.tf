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

variable "certificate_validate" {
  type        = bool
  description = "Whether validate the certificate in R53 zone or not."
  default     = true
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
    cors_rule       = optional(list(any), [])
    event_notification_config = optional(object({
      target_type   = string,                                        // Target type for the S3 event notification, can be "sqs" or "null". Other target types can be implemented in the future.
      name_suffix   = string,                                        // Suffix to add to the target name.
      filter_prefix = string,                                        // Prefix to filter object key names for the event notification.
      events        = optional(list(string), ["s3:ObjectCreated:*"]) // List of S3 events that trigger the notification. Defaults to "s3:ObjectCreated:*".
      }), {
      target_type   = "null"
      name_suffix   = "event"
      filter_prefix = "test/"
      events        = ["s3:ObjectCreated:*"]
      }
    )
    lifecycle_rules = optional(any, []) # List of maps containing configuration of object lifecycle management. This can be used to remove expired object based on passed days starting from object creation
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
    event-notification-config = {
      target_type   = "null"
      queue_name    = "test"
      filter_prefix = "test/"
      events        = ["s3:ObjectCreated:*"]
    }
  }
  description = "S3 bucket configuration options"
}

variable "cdn_configs" {
  type = object({
    default_root_object  = optional(string, "index.html")
    default_behavior     = optional(any, {})
    additional_origins   = optional(any, [])
    s3_is_default_origin = optional(bool, true)
    s3_path_pattern      = optional(string, "/static*")
  })
  default = {
    default_root_object  = "index.html"
    additional_origins   = []
    s3_is_default_origin = true
    s3_path_pattern      = "/static*"
  }
  description = "CDN configuration options"
}
