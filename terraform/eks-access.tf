# Grants the GitHub Actions IAM user permission to actually run kubectl
# commands against this cluster. AWS IAM alone is not enough for that —
# EKS has its own separate RBAC layer, scoped here to edit access within
# the namegen namespace only (not full cluster-admin).

resource "aws_eks_access_entry" "github_actions" {
  cluster_name  = aws_eks_cluster.main.name
  principal_arn = var.github_actions_iam_user_arn
}

resource "aws_eks_access_policy_association" "github_actions_edit" {
  cluster_name  = aws_eks_cluster.main.name
  principal_arn = var.github_actions_iam_user_arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSEditPolicy"

  access_scope {
    type       = "namespace"
    namespaces = ["namegen"]
  }
}
