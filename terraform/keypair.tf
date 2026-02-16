resource "tls_private_key" "strapi_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "strapi_key" {
  key_name   = "strapi-key"
  public_key = tls_private_key.strapi_key.public_key_openssh
}
