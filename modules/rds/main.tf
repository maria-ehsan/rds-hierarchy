resource "aws_db_instance" "rds_instance" {
  count                           = var.instance_count
  replicate_source_db             = length(var.source_instance_identifier) > 0 ? lookup(var.rds_instances[count.index], "source_instance_identifier") : var.source_instance_identifier
  identifier                      = lookup(var.rds_instances[count.index], "instance_identifier")
  storage_type                    = lookup(var.rds_instances[count.index], "storage_type")
  iops                            = lookup(var.rds_instances[count.index], "iops")
  instance_class                  = lookup(var.rds_instances[count.index], "instance_class")
  parameter_group_name            = lookup(var.rds_instances[count.index], "parameter_group_name")
  backup_retention_period         = var.backup_retention_enabled
  availability_zone               = lookup(var.rds_instances[count.index], "availability_zone")
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade
  backup_window                   = var.backup_window
  publicly_accessible             = var.publicly_accessible
  tags                            = var.rds_tags
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  monitoring_interval             = var.monitoring_interval
  monitoring_role_arn             = var.monitoring_role_arn
  apply_immediately               = var.apply_immediately

  provisioner "local-exec" {
    // instance should be rebooted in order to sync parameter group
    command = "aws rds reboot-db-instance --db-instance-identifier ${lookup(var.rds_instances[count.index], "instance_identifier")} && aws rds wait db-instance-available --db-instance-identifier ${lookup(var.rds_instances[count.index], "instance_identifier")}"
  }

  timeouts {
    create = "300m"
  }
}
