output "vpc_id" {
  value = aws_vpc.main.id
}

output "frontend_subnets" {
  value = aws_subnet.frontend.*.id
}

output "backend_subnets" {
  value = aws_subnet.backend.*.id
}

output "db_subnets" {
  value = aws_subnet.db.*.id
}

output "public_subnets" {
  value = aws_subnet.public.*.id
}