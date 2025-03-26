output "EC2_INSTANCE_PUBLIC_IP" {
  value = aws_instance.compute_instance.public_ip
}