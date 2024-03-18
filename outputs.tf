output "cluster_name" {
  value = aws_eks_cluster.aws_eks.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.aws_eks.endpoint
}

output "security_group_id" {
  value = aws_security_group.sg.id
}

#output "kubeconfig" {
#  value = aws_eks_cluster.my_cluster.kubeconfig
#}

