# create 2 private and 2 public subnet for EKS
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet

resource "aws_subnet" "publicEKS_1" {

  # VPC id is 
  vpc_id = aws_vpc.ArjunVpcEKS.id

  # CIDR block for subnet
  cidr_block = "192.168.0.0/18"

  # Avaliability zone for the subnet
  availability_zone = "ap-south-1a"

  # Required for EKS - when instance create in this subnet so should be assigned public ip automatically
  map_public_ip_on_launch = true

  # A map of tags to assign  to the resource
  tags = {
    Name                        = "Public-ap-south-1a"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}

resource "aws_subnet" "publicEKS_2" {

  # VPC id is 
  vpc_id = aws_vpc.ArjunVpcEKS.id

  # CIDR block for subnet
  cidr_block = "192.168.64.0/18"

  # Avaliability zone for the subnet
  availability_zone = "ap-south-1b"

  # Required for EKS - when instance create in this subnet so should be assigned public ip automatically
  map_public_ip_on_launch = true

  # A map of tags to assign  to the resource
  tags = {
    Name                        = "Public-ap-south-1b"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}

resource "aws_subnet" "privateEKS_1" {

  # VPC id is 
  vpc_id = aws_vpc.ArjunVpcEKS.id

  # CIDR block for subnet
  cidr_block = "192.168.128.0/18"

  # Avaliability zone for the subnet
  availability_zone = "ap-south-1a"

  # Required for EKS - when instance create in this subnet so should be assigned public ip automatically
  map_public_ip_on_launch = true

  # A map of tags to assign  to the resource
  tags = {
    Name                        = "Private-ap-south-1a"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
}


resource "aws_subnet" "privateEKS_2" {

  # VPC id is 
  vpc_id = aws_vpc.ArjunVpcEKS.id

  # CIDR block for subnet
  cidr_block = "192.168.192.0/18"

  # Avaliability zone for the subnet
  availability_zone = "ap-south-1b"

  # Required for EKS - when instance create in this subnet so should be assigned public ip automatically
  map_public_ip_on_launch = true

  # A map of tags to assign  to the resource
  tags = {
    Name                        = "Private-ap-south-1a"
    "kubernetes.io/cluster/eks" = "shared"
    "kubernetes.io/role/elb"    = 1
  }
} 