provider "aws" {
  region = var.AWS_REGION
}

# Current terraform AWS Identity
data "aws_caller_identity" "this" {
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

# # Data source used to avoid race condition
# data "aws_vpc_endpoint" "dynamodb" {
#   vpc_id       = module.vpc.vpc_id
#   service_name = "com.amazonaws.${var.AWS_REGION}.dynamodb"
# }

# data "aws_iam_policy_document" "dynamodb_endpoint_policy" {
#   statement {
#     effect    = "Deny"
#     actions   = ["dynamodb:*"]
#     resources = ["*"]

#     principals {
#       type        = "*"
#       identifiers = ["*"]
#     }

#     condition {
#       test     = "StringNotEquals"
#       variable = "aws:sourceVpce"

#       values = [data.aws_vpc_endpoint.dynamodb.id]
#     }
#   }
# }

# data "aws_iam_policy_document" "generic_endpoint_policy" {
#   statement {
#     effect    = "Deny"
#     actions   = ["*"]
#     resources = ["*"]

#     principals {
#       type        = "*"
#       identifiers = ["*"]
#     }

#     condition {
#       test     = "StringNotEquals"
#       variable = "aws:sourceVpce"

#       values = [data.aws_vpc_endpoint.dynamodb.id]
#     }
#   }
# }

data "aws_availability_zones" "available" {
}

module "vpc" {
  source    = "terraform-aws-modules/vpc/aws"
  version   = "~> 2.0"
  name      = "${var.ENV_TYPE}-${var.ENV_NAME}-vpc"
  cidr      = var.VPC_CIDR

  create_vpc      = true
  azs             = data.aws_availability_zones.available.names
  private_subnets = var.VPC_PRIVATE_SUBNETS
  public_subnets  = var.VPC_PUBLIC_SUBNETS

  enable_nat_gateway      = true
  single_nat_gateway      = true
  one_nat_gateway_per_az  = false
  enable_vpn_gateway      = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  manage_default_route_table = true
  default_route_table_tags   = { DefaultRouteTable = true }

  enable_classiclink             = false
  enable_classiclink_dns_support = false

  # # VPC endpoint for S3
  # enable_s3_endpoint              = true
  # s3_endpoint_type                = "Interface"
  # s3_endpoint_private_dns_enabled = false
  # s3_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # # VPC endpoint for DynamoDB
  # enable_dynamodb_endpoint = true
  # dynamodb_endpoint_policy = data.aws_iam_policy_document.dynamodb_endpoint_policy.json

  # # VPC endpoint for Lambda
  # enable_lambda_endpoint              = true
  # lambda_endpoint_private_dns_enabled = true
  # lambda_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # # VPC Endpoint for EC2
  # enable_ec2_endpoint              = true
  # ec2_endpoint_policy              = data.aws_iam_policy_document.generic_endpoint_policy.json
  # ec2_endpoint_private_dns_enabled = true
  # ec2_endpoint_security_group_ids  = [data.aws_security_group.default.id]

  # Default security group - ingress/egress rules cleared to deny all
  manage_default_security_group  = true
  default_security_group_ingress = []
  default_security_group_egress  = []

  # VPC Flow Logs (Cloudwatch log group and IAM role will be created)
  enable_flow_log                      = false
  #create_flow_log_cloudwatch_log_group = false
  #create_flow_log_cloudwatch_iam_role  = false
  #flow_log_max_aggregation_interval    = 60

  tags = merge(
    {
      TF = "true"
      ENV_NAME = var.ENV_NAME
      ENV_TYPE = var.ENV_TYPE
    },
    var.VPC_PUBLIC_SUBNET_TAGS,
    var.VPC_PRIVATE_SUBNET_TAGS,
  )

  vpc_endpoint_tags = {
    TF  = "true"
    ENV_NAME = var.ENV_NAME
    ENV_TYPE = var.ENV_TYPE
    Endpoint = "true"
  }
}
