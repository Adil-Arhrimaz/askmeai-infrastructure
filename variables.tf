variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-west-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "askmeai"
}

variable "environments" {
  description = "Environment-specific configurations"
  type = map(object({
    vpc_cidr_block       = string
    public_subnet_cidrs  = list(string)
    private_subnet_cidrs = list(string)
    availability_zones   = list(string)
    tags                 = map(string)
  }))

  default = {
    dev = {
      vpc_cidr_block       = "10.0.0.0/16"
      public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
      private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
      availability_zones   = ["eu-west-1a", "eu-west-1b"]
      tags = {
        "Environment" = "dev"
      }
    }
    prod = {
      vpc_cidr_block       = "10.1.0.0/16"
      public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
      private_subnet_cidrs = ["10.1.3.0/24", "10.1.4.0/24"]
      availability_zones   = ["eu-west-1a", "eu-west-1b"]
      tags = {
        "Environment" = "prod"
      }
    }
  }
}

locals {
  environment = terraform.workspace
  config      = var.environments[local.environment]
}