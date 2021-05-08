resource "aws_lb_target_group" "my-target-group" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "my-test-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.main.id
}
resource "aws_lb" "my-aws-alb" {
  name     = "my-test-alb"
  internal = false
  security_groups = [
    aws_security_group.my-alb-sg.id,
  ]
  subnets = [
    aws_subnet.public[0].id,
    aws_subnet.public[1].id
  ]
  tags = {
    Name = "my-test-alb"
  }
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
}

resource "aws_lb" "my-aws-alb-private" {
  name     = "my-test-alb-privare"
  internal = true
  security_groups = [
    aws_security_group.my-alb-sg.id,
  ]
  subnets = [
    aws_subnet.private[0].id,
    aws_subnet.private[1].id
  ]
  tags = {
    Name = "my-test-alb-private"
  }
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
}



resource "aws_lb_listener" "my-test-alb-listner" {
  load_balancer_arn = aws_lb.my-aws-alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-target-group.arn
  }
}
// resource "aws_lb_listener" "my-test-alb-listner-private" {
//   load_balancer_arn = aws_lb.my-aws-alb-private.arn
//   port              = 80
//   protocol          = "HTTP"

//   default_action {
//     type             = "forward"
//     target_group_arn = aws_lb_target_group.my-target-group.arn
//   }
// }

resource "aws_security_group" "my-alb-sg" {
  name   = "my-alb-sg"
  vpc_id = aws_vpc.main.id
}

resource "aws_security_group_rule" "inbound_ssh" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.my-alb-sg.id
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "inbound_http" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.my-alb-sg.id
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "outbound_all" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.my-alb-sg.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}

output "alb_dns_name" {
  value = aws_lb.my-aws-alb.dns_name
}

output "alb_target_group_arn" {
  value = aws_lb_target_group.my-target-group.arn
}
resource "aws_lb_target_group" "my-target-group-private" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "my-test1-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.main.id
}
resource "aws_lb_listener" "my-test-alb-listner-private" {
  load_balancer_arn = aws_lb.my-aws-alb-private.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my-target-group-private.arn
  }
}
 output "alb_target_group_arn_private" {
   value = aws_lb_target_group.my-target-group-private.arn
 }
