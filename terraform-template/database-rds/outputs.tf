output "rds_endpoint" {
  description = "RDS endpoint address"
  value       = aws_db_instance.mariadb.address
}

output "rds_port" {
  description = "RDS port"
  value       = aws_db_instance.mariadb.port
}

output "db_username" {
  description = "DB admin username"
  value       = aws_db_instance.mariadb.username
}
