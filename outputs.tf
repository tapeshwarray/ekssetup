output "cluster_name" {
  value = aws_eks_cluster.aws_eks.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.aws_eks.endpoint
}

output "security_group_id" {
  value = aws_security_group.sg.id
}

output "kubeconfig" {
  value = kubernetes_namespace.example.id
}

# Output the EKS Cluster Endpoint using the lookup function
output "eks_cluster_endpoint" {
  value = lookup(aws_eks_cluster.aws_eks, "endpoint", "No endpoint found")
}
