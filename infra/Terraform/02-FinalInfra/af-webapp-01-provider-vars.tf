terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.8.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "eu-central-1"
}

variable "vpc_id" {
  type    = string
  default = "vpc-0fead40e24304ce5f"
}

variable "subnet_id" {
  type    = string
  default = "subnet-0c5ab4a1499db9f85"
}

variable "user_prefix" {
  type    = string
  default = "af"
}

data "aws_vpc" "vpc" {
  id = var.vpc_id
}

data "aws_subnet" "snet" {
  id = var.subnet_id
}