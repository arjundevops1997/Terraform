# Terraform
In this Repo you can learn about create the aws EKS by using terraform. 

1. create Aws account and install terraform latest version in your local system
2. configure aws creds in local with this command

       aws configure --profile  <aws user name which have all permissions for terraform implement (make sure that user have admin access if possible) >
       
3. create provider.tf file 
  (in this file we only explain that our aws region and aws platform and terraform version)
  
4. then we create vpc.tf file & add all required parameter for VPC and at the end we look the output details 

5. Create 4 subnet, two for public and two for private (File name is subnets.tf)

6. create internet gateway (file name internet-gateway.tf)

7. Create two elastic ip for NAT gateway (file name is epis.tf)

8. create two NAT gateway for Backend and Database (file name nat-gateways.tf)

9. Create Route table for traffic control by using public and private subnet (file name is routing-tables.tf)

10. Assosciate route table with public and private subnet (File name is route-table-association.tf)

11. In this 10 steps we already done our virtual private cloud work hurry hurry .................hurry

12 Now we start to create eks cluster. For eks cluster we must have one IAM role policy which have all permission to create resources with the help of your IAM user credentials
     (File name is eks.tf)

13. Then create eks Node group & attach IAM role policy for create ec2 resources (file name is eks-node-groups.tf)

14. all the terraform offical links are attached so plz find the all commented lines for further knowledge 

15. now time to execute commands in your local 
      terraform init
      terraform fmt
      terrafrom plan
      terraform apply or you also use terraform apply --profile <IAM user name which you attach permission for execution>   
