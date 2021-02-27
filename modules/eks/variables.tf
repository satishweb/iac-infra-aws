variable "AWS_REGION" {
  description = "AWS Region"
  type        = string
  default     = "us-west-2"
}

variable "ENV_TYPE" {
  description = "Target environment type"
  type        = string
  default     = "dev"
}

variable "ENV_NAME" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "RESOURCE_NAME" {
  description = "AWS IAM role account name"
  type        = string
  default     = "iam-role-name"
}

variable "EKS_CLUSTER_K8S_VERSION" {
  description = "Kubernetes version"
  type        = string
  default     = "1.19"
}

variable "PUBLIC_CIDRS" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "EKS_CLUSTER_ON_DEMAND_INSTANCE_TYPE" {
  description = "Kubernetes on demand/always on node instance type"
  type        = string
  default     = "t2.medium"
}

variable "EKS_CLUSTER_ON_DEMAND_INSTANCES_MAX_COUNT" {
  description = "ASG max count for kubernetes on-demand type instance nodes"
  type        = number
  default     = 1
}

variable "EKS_CLUSTER_SPOT_INSTANCE_TYPES" {
  description = "Kubernetes spot instance nodes"
  type        = list(string)
  default     = ["m5ad.large","c5ad.large"]
}

variable "EKS_CLUSTER_SPOT_INSTANCE_POOLS_COUNT" {
  description = "Spot instances pools"
  type        = number
  default     = 2
}

variable "EKS_CLUSTER_SPOT_INSTANCE_ASG_MAX_SIZE" {
  description = "ASG Max size of spot instances"
  type        = number
  default     = 2
}

variable "EKS_CLUSTER_SPOT_INSTANCE_DESIRED_CAPACITY" {
  description = "ASG desired capacity for spot instances"
  type        = number
  default     = 1
}
