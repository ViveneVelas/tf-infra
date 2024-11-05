terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

// Criar uma chave privada
resource "tls_private_key" "vivene_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

// Salvar a chave privada em um arquivo .pem
resource "local_file" "private_key" {
  filename = "${path.module}/${var.key_name}.pem"
  content  = tls_private_key.vivene_key.private_key_pem

  // Defina as permissões do arquivo para serem somente leitura para o proprietário
  file_permission = "0400"
}

// Criar o Key Pair no AWS
resource "aws_key_pair" "vivene_key" {
  key_name   = var.key_name
  public_key = tls_private_key.vivene_key.public_key_openssh
}

provider "aws" {
  region = "us-east-1"
}
