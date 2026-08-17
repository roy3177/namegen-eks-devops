# EKS Auto Mode cluster: AWS provisions and manages compute (nodes),
# storage (EBS-backed StorageClass), and load balancer integration
# automatically — no separate aws_eks_node_group or manual EBS CSI driver
# setup is needed (contrast with the classic approach in git history).
resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn
  version  = var.kubernetes_version

  vpc_config {
    subnet_ids              = aws_subnet.public[*].id
    endpoint_public_access  = true
    endpoint_private_access = false
  }

  # Explicit (not relying on the AWS default) so aws_eks_access_entry works,
  # and so the Terraform-creating identity keeps admin access automatically.
  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }

  compute_config {
    enabled       = true
    node_pools    = ["general-purpose", "system"]
    node_role_arn = aws_iam_role.eks_auto_node.arn
  }

  kubernetes_network_config {
    elastic_load_balancing {
      enabled = true
    }
  }

  storage_config {
    block_storage {
      enabled = true
    }
  }

  # Auto Mode manages its own core addons (networking, DNS, storage) — do
  # not also bootstrap the classic self-managed addons.
  bootstrap_self_managed_addons = false

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_cluster_compute_policy,
    aws_iam_role_policy_attachment.eks_cluster_block_storage_policy,
    aws_iam_role_policy_attachment.eks_cluster_load_balancing_policy,
    aws_iam_role_policy_attachment.eks_cluster_networking_policy,
    aws_iam_role_policy_attachment.eks_auto_node_minimal_policy,
    aws_iam_role_policy_attachment.eks_auto_node_registry_policy,
    aws_iam_role_policy_attachment.eks_cluster_instance_profile_policy,
  ]

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
