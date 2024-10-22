// Create Launch Template
resource "aws_launch_template" "web_launch_template" {
  name_prefix   = "web-template"
  image_id      = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size = 8
      volume_type = "gp3"
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "web-server"
    }
  }
}

// Create Auto Scaling Group
resource "aws_autoscaling_group" "web_asg" {
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  vpc_zone_identifier  = aws_subnet.public_subnets[*].id
  target_group_arns    = [aws_lb_target_group.web_tg.arn]
  launch_template {
    id      = aws_launch_template.web_launch_template.id
    version = "$Latest"
  }

  health_check_type = "EC2"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "web-server-asg"
    propagate_at_launch = true
  }
}
