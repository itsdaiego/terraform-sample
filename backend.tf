terraform {
  backend "s3" {
    bucket         = "tftemplate-terraform"
    key            = "tftemplate.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform_locks"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  required_version = ">= 1.0.0"
}
