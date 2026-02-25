# terraform-aws-frontend-app
Repo spins up frontend application setup which include CloudFront distribution, S3 bucket and DNS record, waf.

## Example
```hcl
module "this" {
  source  = "dasmeta/frontend-app/aws"
  version = "1.1.0"

  domain = "basic-test-front-app.devops.dasmeta.com"
  zone   = "devops.dasmeta.com"

  providers = { aws : aws, aws.virginia : aws.virginia }
}
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | > 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.27.0, < 6.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cdn"></a> [cdn](#module\_cdn) | dasmeta/modules/aws//modules/cloudfront-ssl-hsts | 2.18.8 |
| <a name="module_dns"></a> [dns](#module\_dns) | dasmeta/dns/aws | 1.0.4 |
| <a name="module_dns_alternative"></a> [dns\_alternative](#module\_dns\_alternative) | dasmeta/dns/aws | 1.0.4 |
| <a name="module_s3"></a> [s3](#module\_s3) | dasmeta/s3/aws | 1.3.2 |
| <a name="module_waf"></a> [waf](#module\_waf) | dasmeta/modules/aws//modules/waf | 2.15.6 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alternative_domains"></a> [alternative\_domains](#input\_alternative\_domains) | n/a | `list(string)` | `[]` | no |
| <a name="input_alternative_zones"></a> [alternative\_zones](#input\_alternative\_zones) | n/a | `list(string)` | `[]` | no |
| <a name="input_cdn_configs"></a> [cdn\_configs](#input\_cdn\_configs) | CDN configuration options | <pre>object({<br>    default_root_object  = optional(string, "index.html")<br>    default_behavior     = optional(any, {})<br>    additional_origins   = optional(any, [])<br>    s3_is_default_origin = optional(bool, true)<br>    s3_path_pattern      = optional(string, "/static*")<br>  })</pre> | <pre>{<br>  "additional_origins": [],<br>  "default_root_object": "index.html",<br>  "s3_is_default_origin": true,<br>  "s3_path_pattern": "/static*"<br>}</pre> | no |
| <a name="input_certificate_validate"></a> [certificate\_validate](#input\_certificate\_validate) | Whether validate the certificate in R53 zone or not. | `bool` | `true` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | domain full name | `string` | n/a | yes |
| <a name="input_enable_http_security_headers"></a> [enable\_http\_security\_headers](#input\_enable\_http\_security\_headers) | Whether to enable http security headers by creating pass through lambda handler for cdn | `bool` | `false` | no |
| <a name="input_s3_configs"></a> [s3\_configs](#input\_s3\_configs) | S3 bucket configuration options | <pre>object({<br>    acl                     = optional(string, "private")<br>    create_index_html       = optional(bool, true)<br>    ignore_public_acls      = optional(bool, true)<br>    restrict_public_buckets = optional(bool, true)<br>    block_public_acls       = optional(bool, true)<br>    block_public_policy     = optional(bool, true)<br><br>    versioning      = optional(object({ enabled = bool }), { enabled = false })<br>    website         = optional(object({ index_document = string, error_document = string }), { index_document = "index.html", error_document = "index.html" })<br>    create_iam_user = optional(bool, false)<br>    cors_rule       = optional(list(any), [])<br>    event_notification_config = optional(object({<br>      target_type   = string,                                        // Target type for the S3 event notification, can be "sqs" or "null". Other target types can be implemented in the future.<br>      name_suffix   = string,                                        // Suffix to add to the target name.<br>      filter_prefix = string,                                        // Prefix to filter object key names for the event notification.<br>      events        = optional(list(string), ["s3:ObjectCreated:*"]) // List of S3 events that trigger the notification. Defaults to "s3:ObjectCreated:*".<br>      }), {<br>      target_type   = "null"<br>      name_suffix   = "event"<br>      filter_prefix = "test/"<br>      events        = ["s3:ObjectCreated:*"]<br>      }<br>    )<br>    lifecycle_rules = optional(any, []) # List of maps containing configuration of object lifecycle management. This can be used to remove expired object based on passed days starting from object creation<br>  })</pre> | <pre>{<br>  "acl": "private",<br>  "block_public_acls": true,<br>  "block_public_policy": true,<br>  "cors_rule": [],<br>  "create_iam_user": false,<br>  "create_index_html": true,<br>  "event-notification-config": {<br>    "events": [<br>      "s3:ObjectCreated:*"<br>    ],<br>    "filter_prefix": "test/",<br>    "queue_name": "test",<br>    "target_type": "null"<br>  },<br>  "ignore_public_acls": true,<br>  "restrict_public_buckets": true,<br>  "versioning": {<br>    "enabled": false<br>  },<br>  "website": {<br>    "error_document": "index.html",<br>    "index_document": "index.html"<br>  }<br>}</pre> | no |
| <a name="input_waf"></a> [waf](#input\_waf) | waf configs | `any` | `null` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | R53 zone name | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_distribution_id"></a> [distribution\_id](#output\_distribution\_id) | cloudfront distribution id |
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | s3 bucket name/id |
| <a name="output_s3_config"></a> [s3\_config](#output\_s3\_config) | n/a |
| <a name="output_s3_data"></a> [s3\_data](#output\_s3\_data) | The created s3 bucket related output data |
| <a name="output_web_acl_id"></a> [web\_acl\_id](#output\_web\_acl\_id) | waf arm/id |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
