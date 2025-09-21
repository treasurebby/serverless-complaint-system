# Provider and main resources
provider "aws" {
  region = var.aws_region
}

module "lambda" {
  source = "./lambda.tf"
}

module "api_gateway" {
  source = "./api_gateway.tf"
}
