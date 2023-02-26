#Elastic ip for NAT gateway
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip

resource "aws_eip" "nat1" {
  #Elastic ip is required for IGW to exit  prior to association
  #  Use depends_on to set an explicit dependency on the IGW
  depends_on = [aws_internet_gateway.ArjunVpcEKS-IG]
}
resource "aws_eip" "nat2" {
  #Elastic ip is required for IGW to exit  prior to association
  #  Use depends_on to set an explicit dependency on the IGW
  depends_on = [aws_internet_gateway.ArjunVpcEKS-IG]

}