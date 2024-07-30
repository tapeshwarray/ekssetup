variable "aws_eks_cluster" {
  description = "The name of the EKS cluster"
  type        = string
}

#variable "region" {
#  description = "The AWS region where the EKS cluster will be created"
#  type        = string
#}

variable "node_instance_type" {
  description = "The EC2 instance type for the EKS worker nodes"
  type        = string
}


variable "aws_region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "eks_cluster_role_name" {
  description = "Name of the IAM role for the EKS cluster"
  default     = "eks-cluster-role"
}


variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
  default     = ["", ""]
}

variable "security_group_ids" {
  description = "List of security group IDs for the EKS cluster"
  type        = list(string)
  default     = [""]
}

variable "node_group_name" {
  description = "Name of the EKS node group"
  default     = "my-node-group"
}

variable "node_group_desired_capacity" {
  description = "Desired number of worker nodes"
  type        = number
}

variable "node_group_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
}

variable "node_group_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
}

variable "kubernetes_namespace" {
  description = "The name of the namespace"
  type        = string
}
