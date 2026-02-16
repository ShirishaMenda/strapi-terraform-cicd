output "public_ip" {
  value = aws_instance.strapi.public_ip
}

output "ec2_private_key_pem" {
  value     = tls_private_key.strapi_key.private_key_pem
  sensitive = true
}
