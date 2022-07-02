output "instance_identifier" {
  value = aws_db_instance.rds_instance.*.identifier
}