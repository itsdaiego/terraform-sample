provider "aws" {
  region = local.region
}

# Create VPC and public/private subnets
module "vpc" {
  name    = "${local.project}-${terraform.workspace}-vpc"
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.10.0"

  cidr            = local.vpc_cidr_range
  azs             = slice(data.aws_availability_zones.available.names, 0, local.vpc_subnet_count)
  private_subnets = sort(data.template_file.private_cidrsubnet.*.rendered)
  public_subnets  = sort(data.template_file.public_cidrsubnet.*.rendered)

  enable_nat_gateway = true

  tags = local.tags
}

# Create VPC security groups
module "instance-sg" {
  source  = "terraform-aws-modules/security-group/aws//modules/http-80"
  version = "4.4.0"

  name        = "${local.project}-${terraform.workspace}-instance-sg"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = [local.vpc_cidr_range]
}

# Create elastic beanstalk application
module "eb-app" {
  source = "./modules/elastic-beanstalk-application"

  name = "${local.project}-app"
}

module "eb-env" {
  source = "./modules/elastic-beanstalk-environment"

  depends_on = [module.eb-app]

  solution_stack_name = local.solution_stack_name

  # App
  eb_app                  = module.eb-app.name
  env                     = terraform.workspace
  beanstalk_instance_type = local.beanstalk_instance_type
  asg_min_size            = local.context[terraform.workspace].asg_min_size
  asg_max_size            = local.context[terraform.workspace].asg_max_size

  # Security
  instance_security_groups = module.instance-sg.security_group_id

  # Network
  vpc_id              = module.vpc.vpc_id
  instance_subnet_ids = module.vpc.private_subnets
  lb_subnet_ids       = module.vpc.public_subnets

  # IAM
  instance_profile = data.aws_iam_role.beanstalk_ec2.name

  tags = local.tags

  # ENV
  NODE_ENV     = terraform.workspace
  DATABASE_URL = "postgres://${var.rds_username}:${var.rds_password}@${aws_rds_cluster.aurora.endpoint}:${aws_rds_cluster.aurora.port}/${aws_rds_cluster.aurora.database_name}"

  PORT       = 8081
  AWS_REGION = local.region
}
