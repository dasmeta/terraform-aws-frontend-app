
variable "domain" {
  type        = string
  description = "domain full name"
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

