resource "aws_cloudwatch_metric_alarm" "beanstalk_instances_degraded" {
  alarm_name          = "${local.project}-beanstalk-${terraform.workspace}-instances-degraded"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "InstancesDegraded"
  namespace           = "AWS/ElasticBeanstalk"
  period              = "60"
  statistic           = "Average"
  threshold           = "3"

  dimensions = {
    EnvironmentName = module.eb-env.name
  }
}

resource "aws_cloudwatch_metric_alarm" "beanstalk_instances_severe" {
  alarm_name          = "${local.project}-beanstalk-${terraform.workspace}-instances-severe"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "InstancesSevere"
  namespace           = "AWS/ElasticBeanstalk"
  period              = "60"
  statistic           = "Average"
  threshold           = "3"

  dimensions = {
    EnvironmentName = module.eb-env.name
  }
}

resource "aws_cloudwatch_metric_alarm" "beanstalk_instances_requests_4xx" {
  alarm_name          = "${local.project}-beanstalk-${terraform.workspace}-instances-requests-4xx"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "ApplicationRequests4xx"
  namespace           = "AWS/ElasticBeanstalk"
  period              = "60"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    EnvironmentName = module.eb-env.name
  }
}

resource "aws_cloudwatch_metric_alarm" "beanstalk_instances_requests_5xx" {
  alarm_name          = "${local.project}-beanstalk-${terraform.workspace}-instances-requests-5xx"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "1"
  metric_name         = "ApplicationRequests5xx"
  namespace           = "AWS/ElasticBeanstalk"
  period              = "60"
  statistic           = "Average"
  threshold           = "5"

  dimensions = {
    EnvironmentName = module.eb-env.name
  }
}
