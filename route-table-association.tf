# route table association 
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association
resource "aws_route_table_association" "publicEKS_1" {
  # subnet id to create association
  subnet_id = aws_subnet.publicEKS_1.id

  # the ID of the routing table to associate with 
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "publicEKS_2" {
  # subnet id to create association
  subnet_id = aws_subnet.publicEKS_2.id

  # the ID of the routing table to associate with 
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "privateEKS_1" {
  # subnet id to create association
  subnet_id = aws_subnet.privateEKS_1.id

  # the ID of the routing table to associate with 
  route_table_id = aws_route_table.private1.id
}

resource "aws_route_table_association" "privateEKS_2" {
  # subnet id to create association
  subnet_id = aws_subnet.privateEKS_2.id

  # the ID of the routing table to associate with 
  route_table_id = aws_route_table.private2.id
}

