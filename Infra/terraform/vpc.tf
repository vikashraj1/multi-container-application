resource "aws_vpc" "ubuntu" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  #   enable_dns_support   = "true"
  #   enable_dns_hostnames = "true"
  tags = {
    Name = "ubuntu-vpc"
  }
}

resource "aws_subnet" "ubuntu_subnet" {
  vpc_id     = aws_vpc.ubuntu.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "ubuntu-subnet"
  }
}