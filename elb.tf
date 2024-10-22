// Application Load Balancer (ALB)
resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false                           // Define se o LB é público ou interno
  load_balancer_type = "application"                   // Tipo do Load Balancer: Application
  security_groups    = [aws_security_group.lb_sg.id]   // Grupo de Segurança do LB
  subnets            = aws_subnet.public_subnets[*].id // Subnets públicas para o ALB

  enable_deletion_protection = false

  tags = {
    Name = "app-lb"
  }
}

// Target Group do ALB
resource "aws_lb_target_group" "app_tg" {
  name        = "app-tg"
  port        = 80              // Porta onde o tráfego será direcionado
  protocol    = "HTTP"          // Protocolo usado
  vpc_id      = aws_vpc.main.id // VPC associada ao grupo de destino
  target_type = "instance"      // Tipo de destino (instâncias EC2)

  health_check {
    healthy_threshold   = 2 // Threshold para instâncias saudáveis
    unhealthy_threshold = 2 // Threshold para instâncias não saudáveis
    timeout             = 5
    interval            = 30
    path                = "/"
    matcher             = "200"
  }

  tags = {
    Name = "app-tg"
  }
}

// Listener para o ALB
resource "aws_lb_listener" "app_lb_listener" {
  load_balancer_arn = aws_lb.app_lb.arn // ARN do Load Balancer
  port              = "80"              // Porta para o tráfego de entrada
  protocol          = "HTTP"            // Protocolo usado (HTTP)

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn // Grupo de destino associado
  }
}
