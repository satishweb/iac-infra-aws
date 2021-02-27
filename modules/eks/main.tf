locals {
  eks_cluster_name = "${var.ENV_TYPE}-${var.ENV_NAME}-eks-cluster"
}
provider "aws" {
  region = var.AWS_REGION
}

# Current terraform AWS Identity
data "aws_caller_identity" "this" {
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

module "vpc" {
  source          = "../vpc"
  VPC_PUBLIC_SUBNET_TAGS = {
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  VPC_PRIVATE_SUBNET_TAGS = {
    "kubernetes.io/cluster/${local.eks_cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
  # using defaults from upstream module
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 14.0"
  cluster_name    = local.eks_cluster_name
  cluster_version = var.EKS_CLUSTER_K8S_VERSION
  create_eks      = true
  subnets         = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  #cluster_enabled_log_types = ["api","audit","authenticator","controllerManager","scheduler"]
  tags = {
    TF = "true"
    ENV_NAME = var.ENV_NAME
    ENV_TYPE = var.ENV_TYPE
  }
  worker_create_initial_lifecycle_hooks = true
  workers_group_defaults = {
    root_volume_type    = "gp2",
    root_volume_size    = "50",
  }
  iam_path = "/${local.eks_cluster_name}/"
  cluster_endpoint_public_access = true
  cluster_endpoint_public_access_cidrs = var.PUBLIC_CIDRS
  cluster_endpoint_private_access = true
  cluster_endpoint_private_access_cidrs = module.vpc.private_subnets_cidr_blocks

  worker_groups = [
    {
      name                = "${local.eks_cluster_name}-on-demand-instances"
      instance_type       = var.EKS_CLUSTER_ON_DEMAND_INSTANCE_TYPE
      asg_max_size        = var.EKS_CLUSTER_ON_DEMAND_INSTANCES_MAX_COUNT
      kubelet_extra_args  = "--node-labels=node.kubernetes.io/lifecycle=normal"
      suspended_processes = ["AZRebalance"]
      additional_security_group_ids = [aws_security_group.nodes_security_groups.id]
    },
  ]

  # Ensure termination handler is used in case of spot instance use
  #  helm install stable/k8s-spot-termination-handler --namespace kube-system
  worker_groups_launch_template = [
    {
      name                    = "${local.eks_cluster_name}-spot-instances"
      override_instance_types = var.EKS_CLUSTER_SPOT_INSTANCE_TYPES
      spot_instance_pools     = var.EKS_CLUSTER_SPOT_INSTANCE_POOLS_COUNT
      asg_max_size            = var.EKS_CLUSTER_SPOT_INSTANCE_ASG_MAX_SIZE
      asg_desired_capacity    = var.EKS_CLUSTER_SPOT_INSTANCE_DESIRED_CAPACITY
      kubelet_extra_args      = "--node-labels=node.kubernetes.io/lifecycle=spot --node-group-auto-discovery=asg:tag=k8s.io/cluster-autoscaler/enabled,k8s.io/cluster-autoscaler/${local.eks_cluster_name}"
      public_ip               = false
      additional_security_group_ids = [aws_security_group.nodes_security_groups.id]
    },
  ]
  worker_additional_security_group_ids = [aws_security_group.all_nodes_mgmt_security_group.id]
}

resource "aws_security_group" "nodes_security_groups" {
  name_prefix = "${local.eks_cluster_name}-nodes-security-groups"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      module.vpc.vpc_cidr_block,
    ]
  }
}

resource "aws_security_group" "all_nodes_mgmt_security_group" {
  name_prefix = "${local.eks_cluster_name}-all-nodes-mgmt-security-group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
      "172.16.0.0/12",
      "192.168.0.0/16",
    ]
  }
}

# Worker node auto scaling
# install autoscaler helm chart: https://github.com/terraform-aws-modules/terraform-aws-eks/blob/master/docs/autoscaling.md
resource "aws_iam_role_policy_attachment" "workers_autoscaling" {
  policy_arn = aws_iam_policy.worker_autoscaling.arn
  role       = module.eks.worker_iam_role_name
}

resource "aws_iam_policy" "worker_autoscaling" {
  name_prefix = "${local.eks_cluster_name}-worker-autoscaling"
  description = "EKS worker node autoscaling policy for cluster ${local.eks_cluster_name}"
  policy      = data.aws_iam_policy_document.worker_autoscaling.json
  path        = "/${local.eks_cluster_name}/"
}

data "aws_iam_policy_document" "worker_autoscaling" {
  statement {
    sid    = "eksWorkerAutoscalingAll"
    effect = "Allow"

    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "ec2:DescribeLaunchTemplateVersions",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "eksWorkerAutoscalingOwn"
    effect = "Allow"

    actions = [
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "autoscaling:UpdateAutoScalingGroup",
    ]

    resources = ["*"]

    condition {
      test     = "StringEquals"
      variable = "autoscaling:ResourceTag/kubernetes.io/cluster/${local.eks_cluster_name}"
      values   = ["owned"]
    }

    condition {
      test     = "StringEquals"
      variable = "autoscaling:ResourceTag/k8s.io/cluster-autoscaler/enabled"
      values   = ["true"]
    }
  }
}
