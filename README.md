# Terraform Template

## Introduction

This is a template project to illustrate Terraform's basic functionalities and workflow.


## Getting Started

To set up the project locally, do the following:

- `terraform init` - downloads all necessary Terraform modules, plugins and providers.
- `terraform workspace new [development|production]` -> `terraform workspace select [development|production]` - this is the sandbox environment used to deploy applications
- `terraform plan -var-file="secrets.tfvars"` - make sure that you're in the correct workspace and that the changes shown are what you expect
- `terraform apply -var-file="secrets.tfvars"` - creates or updates infrastructure according to plan

_Note: This project uses Terraform 1.0.0, to easily switch to this version use [tfswitch](https://tfswitch.warrensbox.com/)_
