# EB Solution Stack
variable "solution_stack_name" {
  description = "Solution stack name"
}

# App
variable "eb_app" {
  description = "Elastic Beanstalk application name"
}

variable "env" {
  description = "dev|stage|prod"
}

variable "beanstalk_instance_type" {
  description = "AWS Elastic Beanstalk instance type"
}

variable "asg_min_size" {
  description = "Minimum number of nodes configured in the Auto Scaling Group"
}

variable "asg_max_size" {
  description = "Maximum number of nodes configured in the Auto Scaling Group"
}

# Network
variable "vpc_id" {
  description = "Elastic Beanstalk VPC ID"
}

variable "instance_subnet_ids" {
  description = "Comma separated list of private instance subnets"
}

variable "lb_subnet_ids" {
  description = "Comma separated list of public lb subnets"
}

variable "tags" {
  description = "Tags to be applied"
}

# Security
variable "instance_security_groups" {
  description = "Comma separated list of instance security groups"
}

# IAM
variable "instance_profile" {
  description = "EC2 InstanceProfile"
}

# ENV variables
variable "NODE_ENV" {
  description = "Node environment type"
}

variable "DATABASE_URL" {
  description = "Database url"
}

variable "PORT" {
  description = "Application default port"
}

variable "AWS_REGION" {
  description = "AWS region"
}
