resource "tls_private_key" "strapi_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "strapi_key" {
  key_name   = "shirisha-key"
  public_key = tls_private_key.strapi_key.public_key_openssh
}

resource "local_file" "ssh_key" {
  filename = "${path.module}/shirisha-key.pem"
  content  = tls_private_key.strapi_key.private_key_pem
  file_permission = "0400"
}