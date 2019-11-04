resource "aws_lb" "alb" {
  name                       = "hirayama-test-alb"
  load_balancer_type         = "application"
  internal                   = false
  idle_timeout               = 200
  enable_deletion_protection = false

  subnets = [
    "${aws_subnet.public_subnet.id}"
    
  ]

  security_groups = [
    "${module.test_sg.security_group_id}",
    "${module.test2_sg.security_group_id}",
  ]
}

module "test2_sg" {
  source      = "./security_group"
  name        = "hirayama-test2-sg"
  vpc_id      = "${aws_vpc.vpc.id}"
  port        = 443
  cidr_blocks = ["106.154.130.252/32"]
}

resource "aws_lb_listener" "http_listenner" {
  load_balancer_arn = "${aws_lb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
    }
  }
}

resource "aws_lb_target_group" "target_group" {
  name                 = "hirayama-test"
  vpc_id               = "${aws_vpc.vpc.id}"
  target_type          = "ip"
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 300

  health_check {
    path                = "/"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = 200
    port                = 80
    protocol            = "HTTP"
  }

  depends_on = ["aws_lb.alb"]
}

resource "aws_lb_listener_rule" "listener_rule" {
  listener_arn = "${aws_lb_listener.http_listenner.arn}"
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.target_group.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/*"]
  }
}