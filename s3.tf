// Build Bucket S3
resource "aws_s3_bucket" "s3-bucket" {
  bucket = "vivene-velas-s3-bucket-teste"

  tags = {
    Name = "vivene-velas-s3-bucket-teste"
  }
}
