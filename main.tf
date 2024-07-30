provider "aws" {
  region = var.aws_region
}

resource "aws_eks_cluster" "aws_eks" {
  name     = var.aws_eks_cluster
  role_arn = aws_iam_role.eks_cluster.arn

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_ids
  }


  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSServicePolicy,
  ]

}
resource "aws_eks_node_group" "node" {
  cluster_name    = aws_eks_cluster.aws_eks.name
  node_group_name = var.node_group_name
  #  node_group_name = "node_Testing"
  node_role_arn = aws_iam_role.eks_nodes.arn
  subnet_ids    = var.subnet_ids


  scaling_config {
    desired_size = var.node_group_desired_capacity
    min_size     = var.node_group_min_size
    max_size     = var.node_group_max_size
  }

  instance_types = [var.node_instance_type]

  #  tags = {
  #    Name = "EKS_Cluster_Testing"
  #  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
}



# Define IAM role for the EKS cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = var.eks_cluster_role_name
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Effect" : "Allow",
      "Principal" : {
        "Service" : "eks.amazonaws.com"
      },
      "Action" : "sts:AssumeRole"
    }]
  })
}


resource "aws_security_group" "sg" {
  name    = "sg"
  ingress = []
  egress  = []
}

data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.aws_eks.name
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.aws_eks.name
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

resource "kubernetes_namespace" "example" {
  metadata {
    name = var.kubernetes_namespace
  }
}
