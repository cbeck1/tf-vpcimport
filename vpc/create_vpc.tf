#Create a basic VPC

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.7.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "testvpc" {
    cidr_block = "10.0.0.0/16"
}

output "vpcid" {
    value = aws_vpc.testvpc.id
}
