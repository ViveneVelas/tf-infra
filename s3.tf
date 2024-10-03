// Build Bucket S3
resource "aws_s3_bucket" "s3-bucket" {
  bucket = "vivanevelas-s3-bucket"

  tags = {
    Name = "vivanevelas-s3-bucket"
  }
}
