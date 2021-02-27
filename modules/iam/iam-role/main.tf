provider "aws" {
  region = var.AWS_REGION
}

# Current terraform AWS Identity
data "aws_caller_identity" "this" {
}

# Create assumable IAM role
module "iam_assumable_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "~> 3.0"

  trusted_role_services = [
    "ec2.amazonaws.com",
  ]

  create_role = true
  role_name         = "${var.ENV_TYPE}_${var.ENV_NAME}_${var.RESOURCE_NAME}_role"
  role_description  = "IAM Role for ${var.ENV_TYPE}_${var.ENV_NAME}_${var.RESOURCE_NAME}"
  role_requires_mfa = false
  max_session_duration = var.IAM_MAX_SESSION_DURATION

  custom_role_policy_arns = [
    module.iam_policy.arn,
  ]
  number_of_custom_role_policy_arns = 1
  tags = {
    TF = "true"
    ENV_NAME = var.ENV_NAME
    ENV_TYPE = var.ENV_TYPE
    SA = "${var.ENV_TYPE}-${var.RESOURCE_NAME}-service-account"
  }
}

# IAM Policy for IAM role
module "iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "~> 3.0"

  name        = "${var.ENV_TYPE}_${var.ENV_NAME}_${var.RESOURCE_NAME}_policy"
  path        = "/"
  description = "IAM Policy for ${var.ENV_TYPE}_${var.ENV_NAME}_${var.RESOURCE_NAME}"

  policy = data.aws_iam_policy_document.iam_policy_document.json
}

# IAM Policy document with permissions
data "aws_iam_policy_document" "iam_policy_document" {
  # TODO: Add ability to specify multiple statements via input var
  statement {
    actions = [
    # TODO: Add more granular perms
      "ec2:*",
      "route53:*",
      "s3:*",
    ]
    resources = [
    # TODO: Limit scope further
      "*",
    ]
  }

  statement {
    actions = [
      "secretsmanager:Get*",
    ]
    resources = [
      # TODO: Add ability to specify multiple dynamic arns via input var
      # TODO: Reduce the secrets access scope
      "arn:aws:secretsmanager:${var.AWS_REGION}:${data.aws_caller_identity.this.account_id}:secret:*",
    ]
  }
}
