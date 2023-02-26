#Create two Private route table & one Public Route table
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table

resource "aws_route_table" "public" {
  # VPC Id take
  vpc_id = aws_vpc.ArjunVpcEKS.id

  route {
    # the CIDR block for the route 
    cidr_block = "0.0.0.0/0"

    # Identifier of the VPC internet gateway or a virtual private gateway
    gateway_id = aws_internet_gateway.ArjunVpcEKS-IG.id
  }

  tags = {
    Name = "public"
  }
}

resource "aws_route_table" "private1" {
  # VPC Id take
  vpc_id = aws_vpc.ArjunVpcEKS.id

  route {
    # the CIDR block for the route 
    cidr_block = "0.0.0.0/0"

    # Identifier of the VPC internet gateway or a virtual private gateway
    gateway_id = aws_nat_gateway.gw1.id
  }

  tags = {
    Name = "private1"
  }
}


resource "aws_route_table" "private2" {
  # VPC Id take
  vpc_id = aws_vpc.ArjunVpcEKS.id

  route {
    # the CIDR block for the route 
    cidr_block = "0.0.0.0/0"

    # Identifier of the VPC internet gateway or a virtual private gateway
    gateway_id = aws_nat_gateway.gw2.id
  }

  tags = {
    Name = "private2"
  }
}