# create nat gateway to provide the internet access of the private instance 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway

resource "aws_nat_gateway" "gw1" {
  # the allocation id od the Elastic ip address for the gateway
  allocation_id = aws_eip.nat1.id

  # The subnet id of the subnet in which to place the gateway
  subnet_id = aws_subnet.publicEKS_1.id

  tags = {
    Name = "NAT 1"
  }

}

resource "aws_nat_gateway" "gw2" {
  # the allocation id od the Elastic ip address for the gateway
  allocation_id = aws_eip.nat2.id

  # The subnet id of the subnet in which to place the gateway
  subnet_id = aws_subnet.publicEKS_2.id

  tags = {
    Name = "NAT 2"
  }
}