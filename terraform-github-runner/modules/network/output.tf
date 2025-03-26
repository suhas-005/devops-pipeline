output "PUBLIC_SUBNET_ID" {
  value = aws_subnet.public_subnet.id
}

output "SECURITY_GROUP_ID" {
  value = aws_security_group.security_group.id
}
