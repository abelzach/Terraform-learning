output "public_dns" {
  value = aws_instance.Test_instance.public_dns
  description = "Public DNS - abel"
}

output "subnet_id" {
  value = aws_instance.Test_instance.subnet_id
  description = "Subnet ID - abel"
  sensitive = true
}