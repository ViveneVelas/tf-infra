terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

// Build public EC2 to FrontEnd and Bastion Host:
resource "aws_instance" "ec2-public" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"

  tags = {
    Name = "ec2-public"
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 8
    volume_type = "gp3"
  }
}

// Build private EC2 to Backend:
resource "aws_instance" "ec2-private" {
  ami           = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"

  tags = {
    Name = "ec2-private"
  }

  ebs_block_device {
    device_name = "/dev/sda2"
    volume_size = 8
    volume_type = "gp3"
  }
}

// Build VPC:
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main vpc"
  }
}

// Build subnets
variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = ["10.0.4.0/24", "10.0.5.0/24"]
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
  default     = ["us-east-1a", "us-east-1b"]
}

// Build subnets:
resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidrs[count.index]
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "Private Subnet ${count.index + 1}"
  }
}

// Build internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Internet gateway VPC PI"
  }
}

// Build route table
resource "aws_route_table" "second_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "2nd Route Table"
  }
}

// Associate route table with subnets
resource "aws_route_table_association" "public_subnet_asso" {
  count             = length(var.public_subnet_cidrs)
  subnet_id         = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id    = aws_route_table.second_rt.id
}

// Build Security Group for RDS
resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "rds_security_group"
  }
}

// Build Bucket S3
resource "aws_s3_bucket" "s3-bucket" {
  bucket = "vivanevelas-s3-bucket"

  tags = {
    Name = "vivanevelas-s3-bucket"
  }
}


