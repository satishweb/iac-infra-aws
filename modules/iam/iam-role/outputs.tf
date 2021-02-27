output "iam_role_arn" {
  description = "ARN of IAM role"
  value       = module.iam_assumable_role.this_iam_role_arn
}

output "iam_role_name" {
  description = "Name of IAM role"
  value       = module.iam_assumable_role.this_iam_role_name
}

output "iam_role_path" {
  description = "Path of IAM role"
  value       = module.iam_assumable_role.this_iam_role_path
}

output "iam_policy_id" {
  description = "The policy ID"
  value       = module.iam_policy.id
}

output "iam_policy_arn" {
  description = "The ARN assigned by AWS to this policy"
  value       = module.iam_policy.arn
}

output "iam_policy_name" {
  description = "The name of this policy"
  value       = module.iam_policy.name
}

output "iam_policy_path" {
  description = "The path of the policy in IAM"
  value       = module.iam_policy.path
}
