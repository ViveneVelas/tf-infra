output "public_subnets" {
  description = "IDs of public subnets"
  value       = aws_subnet.public_subnets[*].id
}

output "private_subnets" {
  description = "IDs of private subnets"
  value       = aws_subnet.private_subnets[*].id
}

output "ec2_public_id" {
  description = "ID of the public EC2 instance"
  value       = aws_instance.ec2-public.id
}

output "ec2_private_id" {
  description = "ID of the private EC2 instance"
  value       = aws_instance.ec2-private.id
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.s3-bucket.bucket
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}
