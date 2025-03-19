output "instance_public_ips" {
  value = [
    aws_instance.web_1.public_ip,
    aws_instance.web_2.public_ip,
    
  ]
}
# Output the endpoint of the MySQL RDS instance
output "rds_endpoint" {
  value = aws_db_instance.mysql.endpoint
}