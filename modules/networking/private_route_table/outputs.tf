output "private_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.this.id
}
