# Resource: AWS IAM Role
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role


resource "aws_iam_role" "eks_cluster" {

  # The name of the cluster
  name = "eks_cluster"

  # the policy that grant an entity permission to assume the role
  # Used the access AWS resources that you might not have access to 
  # the role that amazon EKS will use to create AWS resources for Kubernetes clusters
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Resource: aws_iam_role_policy_attachment
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "amazon_eks_clustor_policy" {
  # the ARN of the policy you want to apply
  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKSClusterPolicy
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

  # the role the policy should be applied to
  role = aws_iam_role.eks_cluster.name

}

# Resource: create EKS cluster
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster


resource "aws_eks_cluster" "eks" {
  # name of the clustor
  name = "eks"

  # the amazon resource name (ARN) of the IAM role that provides permissions for the kubernetes control plane to make calls to aws API on your behalf
  role_arn = aws_iam_role.eks_cluster.arn

  # version of the Kubernetes Master 
  version = "1.25"


  vpc_config {
    # Indicate whether or not the Amazon EKS private API server endpoint is enabled
    endpoint_private_access = false

    #Indicate whether or not the Amazon EKS private API server endpoint is enabled
    endpoint_public_access = true

    # Must be at least two avaliability zones
    subnet_ids = [
      aws_subnet.publicEKS_1.id,
      aws_subnet.publicEKS_2.id,
      aws_subnet.privateEKS_1.id,
      aws_subnet.privateEKS_2.id
    ]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_clustor_policy,
  ]
}
