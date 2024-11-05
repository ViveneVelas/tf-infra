resource "aws_launch_configuration" "lc" {
  name          = "example-lc"
  image_id     = "ami-0e86e20dae9224db8"  # ID da AMI fornecida
  instance_type = var.instance_type
  key_name      = var.key_name

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    volume_size = var.volume_size
    volume_type = "gp2"
  }
}

resource "aws_autoscaling_group" "public_asg" {
  desired_capacity     = 1
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier = aws_subnet.public_subnets[*].id
  launch_configuration = aws_launch_configuration.lc.id

  health_check_type          = "EC2"
  health_check_grace_period  = 300

  tags = [
    {
      key                 = "Name"
      value               = "Public-ASG-Instance"
      propagate_at_launch = true
    },
  ]
}

resource "aws_autoscaling_group" "private_asg" {
  desired_capacity     = 1
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier = aws_subnet.private_subnets[*].id
  launch_configuration = aws_launch_configuration.lc.id

  health_check_type          = "EC2"
  health_check_grace_period  = 300

  tags = [
    {
      key                 = "Name"
      value               = "Private-ASG-Instance"
      propagate_at_launch = true
    },
  ]
}
