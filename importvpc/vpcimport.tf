#After importing resource at CLI, we will now trigger run in TFE to validate resource is in state.
#This will trigger a run and add a new tag to the VPC. TFE should indicate 1 change will occur, indicating an existing resource exists and will modify instead of creating new.

provider "aws" {
    region = "us-east-1"
}

resource "aws_vpc" "testvpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
    Owner = "apple"
  }
}

output "vpcid" {
    value = aws_vpc.testvpc.id
}

terraform {
  backend "remote" {
    hostname = ".."
    organization = ".."

    workspaces {
      name = ".."
    }
  }
}