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

variable "VPC_CIDR" {
  description = "VPC CIDR"
  type        = string
  default     = "10.181.0.0/16"
}

variable "VPC_PRIVATE_SUBNETS" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.181.1.0/24", "10.181.2.0/24", "10.181.3.0/24"]
}

variable "VPC_PUBLIC_SUBNETS" {
  description = "List of private subnet CIDRs"
  type        = list(string)
  default     = ["10.181.101.0/24", "10.181.102.0/24", "10.181.103.0/24"]
}

variable "VPC_PUBLIC_SUBNET_TAGS" {
  description = "Additional tags for the public subnets"
  type        = map(string)
  default     = {}
}

variable "VPC_PRIVATE_SUBNET_TAGS" {
  description = "Additional tags for the private subnets"
  type        = map(string)
  default     = {}
}
