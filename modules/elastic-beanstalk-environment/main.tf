# Create Elastic Beanstalk Environment
resource "aws_elastic_beanstalk_environment" "default" {
  name                = terraform.workspace == "production" ? "${var.eb_app}-${substr(terraform.workspace, 0, 4)}" : "${var.eb_app}-${substr(terraform.workspace, 0, 3)}"
  application         = var.eb_app
  solution_stack_name = var.solution_stack_name

  # App configuration
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = var.instance_profile
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.beanstalk_instance_type
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = var.asg_min_size
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.asg_max_size
  }

  # HTTP Listener Configuration
  setting {
    namespace = "aws:elb:listener:80"
    name      = "ListenerProtocol"
    value     = "HTTP"
  }

  setting {
    namespace = "aws:elb:listener:80"
    name      = "InstancePort"
    value     = 80
  }

  setting {
    namespace = "aws:elb:listener:80"
    name      = "ListenerEnabled"
    value     = "true"
  }

  # Network configuration
  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", sort(var.instance_subnet_ids))
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBSubnets"
    value     = join(",", sort(var.lb_subnet_ids))
  }

  # Security configuration
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = var.instance_security_groups
  }

  # ENV variables
  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "NODE_ENV"
    value     = var.NODE_ENV
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "DATABASE_URL"
    value     = var.DATABASE_URL
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "AWS_REGION"
    value     = var.AWS_REGION
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "PORT"
    value     = var.PORT
  }
  # Logs

  setting {
    namespace = "aws:elasticbeanstalk:cloudwatch:logs"
    name      = "StreamLogs"
    value     = "true"
  }

  tags = var.tags
}
