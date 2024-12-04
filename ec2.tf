# Configuração das instâncias EC2 para frontend e backend

resource "aws_instance" "frontend" {
  ami           = "ami-0e86e20dae9224db8" 
  instance_type = "t2.micro"
  key_name      = var.key_name
  subnet_id     = aws_subnet.public.id
  security_groups = [
    aws_security_group.frontend.name
  ]

  tags = {
    Name = "frontend-ec2"
  }
}

resource "aws_instance" "backend" {
  ami           = "ami-0e86e20dae9224db8" 
  instance_type = "t2.micro"
  key_name      = var.key_name
  subnet_id     = aws_subnet.private.id
  security_groups = [
    aws_security_group.backend.name
  ]

  tags = {
    Name = "backend-ec2"
  }
}