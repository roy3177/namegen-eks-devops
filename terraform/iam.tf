resource "aws_iam_role" "eks_cluster" {
  name = "${var.project_name}-eks-cluster-role"

  # sts:TagSession (not just sts:AssumeRole) is required for the
  # eks.amazonaws.com principal — Auto Mode's internal networking/storage
  # automation assumes this role with session tags, and STS rejects that
  # without an explicit allow here even though it's not part of the
  # documented EKSClusterPolicy setup.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "eks.amazonaws.com" }
      Action    = ["sts:AssumeRole", "sts:TagSession"]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# EKS Auto Mode requires the cluster role to also manage compute, storage,
# load balancing and networking resources on your behalf (this replaces the
# manual node group + EBS CSI driver setup we had before).
resource "aws_iam_role_policy_attachment" "eks_cluster_compute_policy" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSComputePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cluster_block_storage_policy" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSBlockStoragePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cluster_load_balancing_policy" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSLoadBalancingPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cluster_networking_policy" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSNetworkingPolicy"
}

# AmazonEKSComputePolicy can only attach an existing instance profile to a
# role (iam:AddRoleToInstanceProfile) — it cannot create one. EKS Auto Mode's
# controller creates and manages its own instance profile automatically, so
# the cluster role needs these extra permissions explicitly (undocumented
# gap in the AWS managed policy, confirmed by inspecting it directly).
resource "aws_iam_policy" "eks_cluster_instance_profile" {
  name = "${var.project_name}-eks-cluster-instance-profile-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "iam:CreateInstanceProfile",
        "iam:DeleteInstanceProfile",
        "iam:GetInstanceProfile",
        "iam:TagInstanceProfile",
        "iam:AddRoleToInstanceProfile",
        "iam:RemoveRoleFromInstanceProfile",
      ]
      Resource = "arn:aws:iam::*:instance-profile/eks*"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_instance_profile_policy" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = aws_iam_policy.eks_cluster_instance_profile.arn
}

# Node role used by EKS Auto Mode's own built-in node pools (we don't manage
# nodes directly anymore). Auto Mode uses its own minimal managed policies
# instead of the classic AmazonEKSWorkerNodePolicy/CNI/ECR-read-only trio.
resource "aws_iam_role" "eks_auto_node" {
  name = "${var.project_name}-eks-auto-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_auto_node_minimal_policy" {
  role       = aws_iam_role.eks_auto_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodeMinimalPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_auto_node_registry_policy" {
  role       = aws_iam_role.eks_auto_node.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"
}
