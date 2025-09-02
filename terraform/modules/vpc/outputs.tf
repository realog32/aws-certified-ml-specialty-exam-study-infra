output "vpc_id" {
  value       = aws_vpc.this.id
  description = "ID of the VPC"
}

output "public_subnet_ids" {
  value       = [for s in aws_subnet.public : s.id]
  description = "IDs of public subnets"
}

output "private_subnet_ids" {
  value       = [for s in aws_subnet.private : s.id]
  description = "IDs of private subnets"
}

output "private_subnet_arns" {
  value       = [for s in aws_subnet.private : s.arn]
  description = "ARNs of private subnets"
}

output "public_route_table_id" {
  value       = aws_route_table.public.id
  description = "Public route table ID"
}


