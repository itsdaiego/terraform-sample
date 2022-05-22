data "aws_region" "current" {}

# Beanstalk service role for managing services
data "aws_iam_role" "beanstalk_service" {
  name = "aws-elasticbeanstalk-service-role"
}

# Beanstalk instance profile for managing ec2
data "aws_iam_role" "beanstalk_ec2" {
  name = "aws-elasticbeanstalk-ec2-role"
}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

data "template_file" "public_cidrsubnet" {
  count = local.vpc_subnet_count

  template = "$${cidrsubnet(vpc_cidr,8,current_count)}"

  vars = {
    vpc_cidr      = local.vpc_cidr_range
    current_count = (count.index * 2) + 1
  }
}

data "template_file" "private_cidrsubnet" {
  count = local.vpc_subnet_count

  template = "$${cidrsubnet(vpc_cidr,8,current_count)}"

  vars = {
    vpc_cidr      = local.vpc_cidr_range
    current_count = count.index * 2
  }
}
