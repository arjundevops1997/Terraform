#aws_VPC
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "ArjunVpcEKS" {

  # cidr block was required part in past  but now its optional 
  cidr_block = "192.168.0.0/16"

  # Makes your instances shared on the host
  instance_tenancy = "default"

  # required for EKS, Enable/Disable DNS support in the VPC
  enable_dns_support = true

  # Required for EKS, Enable/Disable DNS hostname in the VPC
  enable_dns_hostnames = true

  #Enable/Disable classic link in the vpc
  enable_classiclink = false

  # Enable/Disable classic link  DNS support in the vpc
  enable_classiclink_dns_support = false

  # Request an amazon-provDR block with a /56 prefix length
  assign_generated_ipv6_cidr_block = false

  # A map of tags to assign  to resource 
  tags = {
    Name = "ArjunVpcEKS"
  }

}

output "vpc_id" {
  value       = aws_vpc.ArjunVpcEKS.id
  description = "VPC id."
  #Setting an output value  as sensitive prevents terraform from showing 
  sensitive = false
}