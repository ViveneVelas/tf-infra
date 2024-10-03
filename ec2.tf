// Build public EC2 to FrontEnd and Bastion Host
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

// Build private EC2 to Backend
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
