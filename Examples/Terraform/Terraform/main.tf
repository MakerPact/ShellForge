# Configure the AWS Provider
provider "aws" {
  region = "us-east-1" # You can change this to your desired region
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "$ProjectName-vpc"
  }
}

output "vpc_id" {
  value = aws_vpc.main.id
}
