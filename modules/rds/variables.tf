variable "rds_instances" {
  type = list(any)
}

variable "instance_count" {
}

variable "publicly_accessible" {
}

variable "auto_minor_version_upgrade" {
}

variable "backup_retention_enabled" {
}

variable "enabled_cloudwatch_logs_exports" {
  type = list(any)
}

variable "apply_immediately" {
  default = true
}

variable "source_instance_identifier" {
  default = ""
}

variable "backup_window" {
  default = "01:00-01:30"
}

variable "monitoring_interval" {
  default = "1"
}

variable "monitoring_role_arn" {
  default = "arn:aws:iam::617171697645:role/rds-monitoring-role"
}

variable "rds_tags" {
  type = map(string)
  default = {
    "c-name" = "rds_example"
  }
}