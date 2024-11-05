// Public Subnet CIDRs for us-east-1
variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

// Private Subnet CIDRs for us-east-1
variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

// Availability Zones for us-east-1
variable "azs" {
  description = "Availability Zones for the VPC"
  default     = ["us-east-1a", "us-east-1b"]
}

// Key pair name for EC2 instances
variable "key_name" {
  description = "Key pair name for EC2 instances"
  default     = "chave-vivene"
}

// Tipo de instância para EC2
variable "instance_type" {
  description = "Tipo de instância para EC2"
  default     = "t2.micro"
}

// Tamanho do volume EBS
variable "volume_size" {
  description = "Tamanho do volume EBS para EC2"
  default     = 8
}

