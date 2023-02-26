# Internet-Gateway 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
resource "aws_internet_gateway" "ArjunVpcEKS-IG" {

  # the VPC id to create in.
  vpc_id = aws_vpc.ArjunVpcEKS.id

  # create a tag for assign the resource & this tag is same as VPC tag
  tags = {
    Name = "ArjunVpcEKS"
  }
}