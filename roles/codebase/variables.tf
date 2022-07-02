variable "region" {
  default = "eu-west-1"
}

variable "profile" {
  default = "default"
}

variable "publicly_accessible" {
  default = false
}

variable "auto_minor_version_upgrade" {
  default = false
}

variable "enabled_cloudwatch_logs_exports" {
  default = ["audit", "error", "general", "slowquery"]
}