# Configuração do bucket S3 

resource "aws_s3_bucket" "assets" {
  bucket = "frontend-assets-bucket"
  acl    = "public-read"

  tags = {
    Name = "frontend-assets"
  }
}
