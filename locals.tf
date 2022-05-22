locals {
  region  = "us-east-1"
  project = "tftemplate"

  solution_stack_name = "64bit Amazon Linux 2 v5.5.3 running Node.js 14 "

  vpc_subnet_count = 3
  vpc_cidr_range   = "10.0.0.0/16"

  tags = {
    Env         = terraform.workspace
    Application = "Terraform Template"
  }

  context = {
    default = {
      vpc_id                       = ""
      instance_subnet_ids          = []
      lb_subnet_ids                = []
      availability_zones           = []
      aurora_instance_type         = ""
      aurora_instance_type         = ""
      backup_retention_period      = 1
      aurora_instance_count        = 1
      asg_min_size                 = 1
      asg_max_size                 = 1
      bucket_application_artifacts = ""
    }

    development = {
      aurora_instance_type         = "db.t4g.medium"
      beanstalk_instance_type      = "t3.micro"
      aurora_instance_count        = 1
      backup_retention_period      = 3
      asg_min_size                 = 1
      asg_max_size                 = 2
      bucket_application_artifacts = "tftemplate-app-artifacts"
    }

    production = {
      aurora_instance_type         = "db.t4g.medium"
      beanstalk_instance_type      = "t3.small"
      aurora_instance_count        = 3
      backup_retention_period      = 30
      asg_min_size                 = 2
      asg_max_size                 = 10
      bucket_application_artifacts = "tftemplate-app-artifacts-production"
    }
  }

  aurora_instance_type    = local.context[terraform.workspace].aurora_instance_type
  aurora_instance_count   = local.context[terraform.workspace].aurora_instance_count
  beanstalk_instance_type = local.context[terraform.workspace].beanstalk_instance_type
}
