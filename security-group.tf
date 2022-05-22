resource "aws_security_group" "aurora" {
  vpc_id = module.vpc.vpc_id

  name_prefix = "${lower(local.project)}-"

  description = "Inbound and outbound rules for rds aurora traffic"

  tags = local.tags
}

resource "aws_security_group_rule" "instance_inbound" {
  security_group_id = aws_security_group.aurora.id
  description       = "enable all traffic for inbound from EB instances"
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"

  source_security_group_id = module.instance-sg.security_group_id
}

resource "aws_security_group_rule" "rds_outbound" {
  security_group_id = aws_security_group.aurora.id
  description       = "enable all traffic for outbound traffic"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"

  cidr_blocks = ["0.0.0.0/0"]
}
