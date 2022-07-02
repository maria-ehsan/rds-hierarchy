module "level0" {
  source = "../../modules/rds"
  rds_instances = [
    {
      instance_identifier  = "master",
      storage_type         = "io1",
      iops                 = 1500,
      instance_class       = "db.r5.xlarge",
      parameter_group_name = "db-parameter-master",
      availability_zone    = "eu-west-1b",
    }
  ]
  instance_count                  = 1
  backup_retention_enabled        = 1
  publicly_accessible             = var.publicly_accessible
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade
  apply_immediately               = "true"
}
module "level1-source" {
  source = "../../modules/rds"
  rds_instances = [
    {
      instance_identifier        = "replica1",
      source_instance_identifier = module.level0.instance_identifier[0]
      storage_type               = "gp2",
      iops                       = 0,
      instance_class             = "db.r5.xlarge",
      parameter_group_name       = "db-parameter-replica1",
      availability_zone          = "eu-west-1b"
    },
    {
      instance_identifier        = "replica2",
      source_instance_identifier = module.level0.instance_identifier[0]
      storage_type               = "io1",
      iops                       = 1500,
      instance_class             = "db.r5.2xlarge",
      parameter_group_name       = "db-parameter-replica2",
      availability_zone          = "eu-west-1c"
    }
  ]
  instance_count                  = 2
  backup_retention_enabled        = 1
  publicly_accessible             = var.publicly_accessible
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade
  apply_immediately               = "true"
}

module "level1-replica" {
  source = "../../modules/rds"
  rds_instances = [
    {
      instance_identifier        = "replica3",
      source_instance_identifier = module.level0.instance_identifier[0]
      storage_type               = "gp2",
      iops                       = 0,
      instance_class             = "db.r5.xlarge"
      parameter_group_name       = "db-parameter-replica3",
      availability_zone          = "eu-west-1a"
    },
    {
      instance_identifier        = "replica4",
      source_instance_identifier = module.level0.instance_identifier[0]
      storage_type               = "io1",
      iops                       = 1500,
      instance_class             = "db.r5.2xlarge"
      parameter_group_name       = "db-parameter-replica4",
      availability_zone          = "eu-west-1b"
    },
    {
      instance_identifier        = "replica5",
      source_instance_identifier = module.level0.instance_identifier[0]
      storage_type               = "io1",
      iops                       = 1500,
      instance_class             = "db.r5.xlarge"
      parameter_group_name       = "db-parameter-replica5",
      availability_zone          = "eu-west-1c"
    }
  ]
  instance_count                  = 3
  backup_retention_enabled        = 0
  publicly_accessible             = var.publicly_accessible
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade
  apply_immediately               = "true"
}

module "level2-1-replica" {
  source = "../../modules/rds"
  rds_instances = [
    {
      instance_identifier        = "replica1-1",
      source_instance_identifier = module.level1-source.instance_identifier[0]
      instance_class             = "db.r5.xlarge",
      storage_type               = "gp2",
      iops                       = 0,
      parameter_group_name       = "db-parameter-replica1-1",
      availability_zone          = "eu-west-1b"
    },
    {
      instance_identifier        = "replica1-2",
      source_instance_identifier = module.level1-source.instance_identifier[0]
      instance_class             = "db.r5.2xlarge",
      storage_type               = "gp2",
      iops                       = 0,
      parameter_group_name       = "db-parameter-replica1-2",
      availability_zone          = "eu-west-1a"
    },
    {
      instance_identifier        = "replica1-3",
      source_instance_identifier = module.level1-source.instance_identifier[0]
      instance_class             = "db.r5.xlarge",
      storage_type               = "io1",
      iops                       = 1500,
      parameter_group_name       = "db-parameter-replica1-3",
      availability_zone          = "eu-west-1c"
    }
  ]
  instance_count                  = 3
  backup_retention_enabled        = 0
  publicly_accessible             = var.publicly_accessible
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade
  apply_immediately               = "true"
}

module "level2-2-replica" {
  source = "../../modules/rds"
  rds_instances = [
    {
      instance_identifier        = "replica2-1",
      source_instance_identifier = module.level1-source.instance_identifier[1]
      storage_type               = "io1",
      iops                       = 1500,
      instance_class             = "db.r5.2xlarge",
      parameter_group_name       = "db-parameter-replica2-1",
      availability_zone          = "eu-west-1c"
    },
    {
      instance_identifier        = "replica2-2",
      source_instance_identifier = module.level1-source.instance_identifier[1]
      storage_type               = "gp2",
      iops                       = 0,
      instance_class             = "db.r5.4xlarge",
      parameter_group_name       = "db-parameter-replica2-2",
      availability_zone          = "eu-west-1b"
    },
    {
      instance_identifier        = "replica2-3",
      source_instance_identifier = module.level1-source.instance_identifier[1]
      storage_type               = "io1",
      iops                       = 1500,
      instance_class             = "db.r5.xlarge",
      parameter_group_name       = "db-parameter-replica2-3",
      availability_zone          = "eu-west-1c"
    }
  ]
  instance_count                  = 3
  backup_retention_enabled        = 0
  publicly_accessible             = var.publicly_accessible
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade
  apply_immediately               = "true"
}


