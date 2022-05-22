resource "aws_rds_cluster" "aurora" {
  cluster_identifier        = "tftemplate-aurora"
  engine                    = "aurora-postgresql"
  availability_zones        = sort(slice(data.aws_availability_zones.available.names, 0, local.vpc_subnet_count))
  database_name             = "tftemplate${terraform.workspace}"
  master_username           = var.rds_username
  master_password           = var.rds_password
  backup_retention_period   = local.context[terraform.workspace].backup_retention_period
  preferred_backup_window   = "07:00-09:00"
  engine_version            = "11.13"
  final_snapshot_identifier = "catalog-${terraform.workspace}-snapshot-${formatdate("MM-DD-YYYY-HH-m", timestamp())}"
  db_subnet_group_name      = aws_db_subnet_group.default.name
  vpc_security_group_ids    = [aws_security_group.aurora.id]

  tags = local.tags

  lifecycle {
    ignore_changes = [
      final_snapshot_identifier
    ]
  }
}

resource "aws_rds_cluster_instance" "aurora_instance" {
  count                = local.context[terraform.workspace].aurora_instance_count
  cluster_identifier   = aws_rds_cluster.aurora.id
  instance_class       = local.aurora_instance_type
  engine               = aws_rds_cluster.aurora.engine
  engine_version       = aws_rds_cluster.aurora.engine_version
  db_subnet_group_name = aws_db_subnet_group.default.name

  tags = local.tags
}

resource "aws_db_subnet_group" "default" {
  name       = "${local.project}-${terraform.workspace}"
  subnet_ids = module.vpc.private_subnets

  tags = local.tags
}
