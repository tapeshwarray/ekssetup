aws_eks_cluster             = "my-eks-cluster"
aws_region                  = "ap-south-1"
node_instance_type          = "t3.medium"
node_group_name             = "node-testing"
subnet_ids                  = ["subnet-089550e55a20c5d4f", "subnet-0582c35249e96c9b1"]
security_group_ids          = ["sg-0157eb4af1f7cbb0b"]
node_group_desired_capacity = 2
node_group_min_size         = 1
node_group_max_size         = 5

