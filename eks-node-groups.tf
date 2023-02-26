# Resource: AWS IAM Role
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role

# Create IAM role for EKS node group
resource "aws_iam_role" "nodes_general" {

  # The name of the cluster
  name = "eks-node-group-general"

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
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Resource: aws_iam_role_policy_attachment
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "amazon_eks_worker_node_policy_general" {
  # the ARN of the policy you want to apply
  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKSWorkerNodePolicy
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"

  # the role the policy should be applied to
  role = aws_iam_role.nodes_general.name

}

# Resource: aws_iam_role_policy_attachment
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "amazon_eks_cni_policy_general" {
  # the ARN of the policy you want to apply
  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKS_CNI_Policy
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

  # the role the policy should be applied to
  role = aws_iam_role.nodes_general.name

}

# Resource: aws_iam_role_policy_attachment
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "amazon_ec2_container_registry_read_only" {
  # the ARN of the policy you want to apply
  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEC2ContainerRegistryReadOnly
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"

  # the role the policy should be applied to
  role = aws_iam_role.nodes_general.name

}

# Resource: aws_eks_node_group
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group

resource "aws_eks_node_group" "nodes_general" {
  # name of the eks cluster
  cluster_name = aws_eks_cluster.eks.name

  # Name of the eks node group
  node_group_name = "nodes-general"

  # Amazon resource name (ARN) of the IAM Role that provides permission for the EKS Node Group
  node_role_arn = aws_iam_role.nodes_general.arn

  # Identifier of EC2 subnets to associate with the EKS Node Group
  # These subnets must have the following resource tag: kubernetes.io/cluster/CLUSTER_NAME
  # (where CLSTER_NAME is replaced with the name of the EKS cluster)  
  subnet_ids = [
    aws_subnet.privateEKS_1.id,
    aws_subnet.privateEKS_2.id
  ]

  # Configuration block with scaling setting
  scaling_config {
    # Desire number of worker nodes.
    desired_size = 1
    # Maximum number of worker nodes. 
    max_size = 1
    # Minimum number of worker nodes.    
    min_size = 1
  }
  # https://docs.aws.amazon.com/eks/latest/APIReference/API_CreateNodegroup.html
  # Type of Amazon Machine Image (AMI) associated with the EKS Node Group 
  # Valid Value: AL2_x86_64,AL2_x86_64_GPU, AL2_ARM_64
  ami_type = "AL2_x86_64"

  #Type of capacityassociated with the EKS node group
  # Valid value : ON_DEMAND, SPOT
  capacity_type = "ON_DEMAND"

  #Disk Size in GiB for worker nodes
  disk_size = 8

  # Force version update if existing pods are unable to be drained due to a pod disruption bugget issue 
  force_update_version = false

  # list of instance type  associated with the EKS Node Group
  instance_types = ["t2.micro"]
  

  labels = {
    role = "nodes_general"
  }
  # kubernetes version 
  version = "1.25"


  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_worker_node_policy_general,
    aws_iam_role_policy_attachment.amazon_eks_cni_policy_general,
    aws_iam_role_policy_attachment.amazon_ec2_container_registry_read_only,
  ]
}