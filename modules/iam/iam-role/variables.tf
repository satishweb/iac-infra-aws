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

variable "RESOURCE_NAME" {
  description = "AWS IAM role account name"
  type        = string
  default     = "iam-role-name"
}

variable "IAM_MAX_SESSION_DURATION" {
  description = "AWS Region"
  type        = number
  default     = 7200
}
