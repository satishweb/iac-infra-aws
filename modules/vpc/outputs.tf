output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = module.vpc.vpc_arn
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = module.vpc.default_security_group_id
}

output "default_network_acl_id" {
  description = "The ID of the default network ACL"
  value = module.vpc.default_network_acl_id
}

output "default_route_table_id" {
  description = "The ID of the default route table"
  value = module.vpc.default_route_table_id
}

output "vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC"
  value = module.vpc.vpc_main_route_table_id
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value = module.vpc.private_subnets
}

output "private_subnet_arns" {
  description = "List of ARNs of private subnets"
  value = module.vpc.private_subnet_arns
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value = module.vpc.private_subnets_cidr_blocks
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value = module.vpc.public_subnets
}

output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value = module.vpc.public_subnet_arns
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value = module.vpc.public_subnets_cidr_blocks
}

output "public_route_table_ids" {
  description = "List of IDs of public route tables"
  value = module.vpc.public_route_table_ids
}

output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value = module.vpc.private_route_table_ids
}

output "public_internet_gateway_route_id" {
  description = "ID of the internet gateway route."
  value = module.vpc.public_internet_gateway_route_id
}

output "private_nat_gateway_route_ids" {
  description = "List of IDs of the private nat gateway route."
  value = module.vpc.private_nat_gateway_route_ids
}

output "private_route_table_association_ids" {
  description = "List of IDs of the private route table association"
  value = module.vpc.private_route_table_association_ids
}

output "public_route_table_association_ids" {
  description = "List of IDs of the public route table association"
  value = module.vpc.public_route_table_association_ids
}

output "nat_ids" {
  description = "List of allocation ID of Elastic IPs created for AWS NAT Gateway"
  value = module.vpc.nat_ids
}

output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value = module.vpc.nat_public_ips
}

output "natgw_ids" {
  description = "List of NAT Gateway IDs"
  value = module.vpc.natgw_ids
}

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value = module.vpc.igw_id
}

output "igw_arn" {
  description = "The ARN of the Internet Gateway"
  value = module.vpc.igw_arn
}

output "public_network_acl_id" {
  description = "ID of the public network ACL"
  value = module.vpc.public_network_acl_id
}

output "public_network_acl_arn" {
  description = "ARN of the public network ACL"
  value = module.vpc.public_network_acl_arn
}

output "private_network_acl_id" {
  description = "ID of the private network ACL"
  value = module.vpc.private_network_acl_id
}

output "private_network_acl_arn" {
  description = "ARN of the private network ACL"
  value = module.vpc.private_network_acl_arn
}

# VPC Endpoints
output "vpc_endpoint_s3_id" {
  description = "The ID of VPC endpoint for S3"
  value = module.vpc.vpc_endpoint_s3_id
}

output "vpc_endpoint_s3_pl_id" {
  description = "The prefix list for the S3 VPC endpoint."
  value = module.vpc.vpc_endpoint_s3_pl_id
}

output "vpc_endpoint_dynamodb_id" {
  description = "The ID of VPC endpoint for DynamoDB"
  value = module.vpc.vpc_endpoint_dynamodb_id
}

output "vpc_endpoint_dynamodb_pl_id" {
  description = "The prefix list for the DynamoDB VPC endpoint."
  value = module.vpc.vpc_endpoint_dynamodb_pl_id
}

output "vpc_endpoint_config_id" {
  description = "The ID of VPC endpoint for config"
  value = module.vpc.vpc_endpoint_config_id
}

output "vpc_endpoint_config_network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint for config."
  value = module.vpc.vpc_endpoint_config_network_interface_ids
}

output "vpc_endpoint_config_dns_entry" {
  description = "The DNS entries for the VPC Endpoint for config."
  value = module.vpc.vpc_endpoint_config_dns_entry
}

output "vpc_endpoint_secretsmanager_id" {
  description = "The ID of VPC endpoint for secretsmanager"
  value = module.vpc.vpc_endpoint_secretsmanager_id
}

output "vpc_endpoint_secretsmanager_network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint for secretsmanager."
  value = module.vpc.vpc_endpoint_secretsmanager_network_interface_ids
}

output "vpc_endpoint_secretsmanager_dns_entry" {
  description = "The DNS entries for the VPC Endpoint for secretsmanager."
  value = module.vpc.vpc_endpoint_secretsmanager_dns_entry
}

output "vpc_endpoint_ec2_id" {
  description = "The ID of VPC endpoint for EC2"
  value = module.vpc.vpc_endpoint_ec2_id
}

output "vpc_endpoint_ec2_network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint for EC2"
  value = module.vpc.vpc_endpoint_ec2_network_interface_ids
}

output "vpc_endpoint_ec2_dns_entry" {
  description = "The DNS entries for the VPC Endpoint for EC2."
  value = module.vpc.vpc_endpoint_ec2_dns_entry
}

output "vpc_endpoint_ec2_autoscaling_id" {
  description = "The ID of VPC endpoint for EC2 Autoscaling"
  value = module.vpc.vpc_endpoint_ec2_autoscaling_id
}

output "vpc_endpoint_ec2_autoscaling_network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint for EC2 Autoscaling"
  value = module.vpc.vpc_endpoint_ec2_autoscaling_network_interface_ids
}

output "vpc_endpoint_ec2_autoscaling_dns_entry" {
  description = "The DNS entries for the VPC Endpoint for EC2 Autoscaling."
  value = module.vpc.vpc_endpoint_ec2_autoscaling_dns_entry
}

output "vpc_endpoint_ecr_api_id" {
  description = "The ID of VPC endpoint for ECR API"
  value = module.vpc.vpc_endpoint_ecr_api_id
}

output "vpc_endpoint_ecr_api_network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint for ECR API."
  value = module.vpc.vpc_endpoint_ecr_api_network_interface_ids
}

output "vpc_endpoint_ecr_api_dns_entry" {
  description = "The DNS entries for the VPC Endpoint for ECR API."
  value = module.vpc.vpc_endpoint_ecr_api_dns_entry
}

output "vpc_endpoint_ecr_dkr_id" {
  description = "The ID of VPC endpoint for ECR DKR"
  value = module.vpc.vpc_endpoint_ecr_dkr_id
}

output "vpc_endpoint_ecr_dkr_network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint for ECR DKR."
  value = module.vpc.vpc_endpoint_ecr_dkr_network_interface_ids
}

output "vpc_endpoint_ecr_dkr_dns_entry" {
  description = "The DNS entries for the VPC Endpoint for ECR DKR."
  value = module.vpc.vpc_endpoint_ecr_dkr_dns_entry
}

output "vpc_endpoint_monitoring_id" {
  description = "The ID of VPC endpoint for CloudWatch Monitoring"
  value = module.vpc.vpc_endpoint_monitoring_id
}

output "vpc_endpoint_monitoring_network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint for CloudWatch Monitoring."
  value = module.vpc.vpc_endpoint_monitoring_network_interface_ids
}

output "vpc_endpoint_monitoring_dns_entry" {
  description = "The DNS entries for the VPC Endpoint for CloudWatch Monitoring."
  value = module.vpc.vpc_endpoint_monitoring_dns_entry
}

output "vpc_endpoint_logs_id" {
  description = "The ID of VPC endpoint for CloudWatch Logs"
  value = module.vpc.vpc_endpoint_logs_id
}

output "vpc_endpoint_logs_network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint for CloudWatch Logs."
  value = module.vpc.vpc_endpoint_logs_network_interface_ids
}

output "vpc_endpoint_logs_dns_entry" {
  description = "The DNS entries for the VPC Endpoint for CloudWatch Logs."
  value = module.vpc.vpc_endpoint_logs_dns_entry
}

output "vpc_endpoint_elasticloadbalancing_id" {
  description = "The ID of VPC endpoint for Elastic Load Balancing"
  value = module.vpc.vpc_endpoint_elasticloadbalancing_id
}

output "vpc_endpoint_elasticloadbalancing_network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint for Elastic Load Balancing."
  value = module.vpc.vpc_endpoint_elasticloadbalancing_network_interface_ids
}

output "vpc_endpoint_elasticloadbalancing_dns_entry" {
  description = "The DNS entries for the VPC Endpoint for Elastic Load Balancing."
  value = module.vpc.vpc_endpoint_elasticloadbalancing_dns_entry
}

output "vpc_endpoint_cloudtrail_id" {
  description = "The ID of VPC endpoint for CloudTrail"
  value = module.vpc.vpc_endpoint_cloudtrail_id
}

output "vpc_endpoint_cloudtrail_network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint for CloudTrail."
  value = module.vpc.vpc_endpoint_cloudtrail_network_interface_ids
}

output "vpc_endpoint_cloudtrail_dns_entry" {
  description = "The DNS entries for the VPC Endpoint for CloudTrail."
  value = module.vpc.vpc_endpoint_cloudtrail_dns_entry
}

output "vpc_endpoint_sts_id" {
  description = "The ID of VPC endpoint for STS"
  value = module.vpc.vpc_endpoint_sts_id
}

output "vpc_endpoint_sts_network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint for STS."
  value = module.vpc.vpc_endpoint_sts_network_interface_ids
}

output "vpc_endpoint_sts_dns_entry" {
  description = "The DNS entries for the VPC Endpoint for STS."
  value = module.vpc.vpc_endpoint_sts_dns_entry
}

output "vpc_endpoint_storagegateway_id" {
  description = "The ID of VPC endpoint for Storage Gateway"
  value = module.vpc.vpc_endpoint_storagegateway_id
}

output "vpc_endpoint_storagegateway_network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint for Storage Gateway."
  value = module.vpc.vpc_endpoint_storagegateway_network_interface_ids
}

output "vpc_endpoint_storagegateway_dns_entry" {
  description = "The DNS entries for the VPC Endpoint for Storage Gateway."
  value = module.vpc.vpc_endpoint_storagegateway_dns_entry
}

output "vpc_endpoint_ses_id" {
  description = "The ID of VPC endpoint for SES"
  value = module.vpc.vpc_endpoint_ses_id
}

output "vpc_endpoint_ses_network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint for SES."
  value = module.vpc.vpc_endpoint_ses_network_interface_ids
}

output "vpc_endpoint_ses_dns_entry" {
  description = "The DNS entries for the VPC Endpoint for SES."
  value = module.vpc.vpc_endpoint_ses_dns_entry
}


output "vpc_endpoint_rds_id" {
  description = "The ID of VPC endpoint for RDS"
  value = module.vpc.vpc_endpoint_rds_id
}

output "vpc_endpoint_rds_network_interface_ids" {
  description = "One or more network interfaces for the VPC Endpoint for RDS."
  value = module.vpc.vpc_endpoint_rds_network_interface_ids
}

output "vpc_endpoint_rds_dns_entry" {
  description = "The DNS entries for the VPC Endpoint for RDS."
  value = module.vpc.vpc_endpoint_rds_dns_entry
}

# VPC flow log
output "vpc_flow_log_id" {
  description = "The ID of the Flow Log resource"
  value = module.vpc.vpc_flow_log_id
}

output "vpc_flow_log_destination_arn" {
  description = "The ARN of the destination for VPC Flow Logs"
  value = module.vpc.vpc_flow_log_destination_arn
}

output "vpc_flow_log_destination_type" {
  description = "The type of the destination for VPC Flow Logs"
  value = module.vpc.vpc_flow_log_destination_type
}

output "vpc_flow_log_cloudwatch_iam_role_arn" {
  description = "The ARN of the IAM role used when pushing logs to Cloudwatch log group"
  value = module.vpc.vpc_flow_log_cloudwatch_iam_role_arn
}

# Static values (arguments)
output "azs" {
  description = "A list of availability zones specified as argument to this module"
  value = module.vpc.azs
}

output "name" {
  description = "The name of the VPC specified as argument to this module"
  value = module.vpc.name
}