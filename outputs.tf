output "appstream_fleet_arn" {
  description = "The ARN of the AppStream fleet"
  value       = aws_appstream_fleet.appstream_fleet.arn
}

output "appstream_stack_arn" {
  description = "The ARN of the AppStream stack"
  value       = aws_appstream_stack.appstream_stack.arn
}

output "appstream_stack_access_endpoints" {
  description = "The access endpoints for the AppStream stack"
  value       = {
    streaming_url = "https://${var.aws_region}.console.aws.amazon.com/appstream2/home?region=${var.aws_region}#/stacks/details/${aws_appstream_stack.appstream_stack.name}"
  }
}

output "vpc_id" {
  description = "The ID of the VPC used for AppStream resources"
  value       = local.vpc_id
}

output "subnet_ids" {
  description = "The IDs of the subnets used for AppStream resources"
  value       = local.subnet_ids
}

output "security_group_id" {
  description = "The ID of the security group used for AppStream resources"
  value       = aws_security_group.appstream_sg.id
}

output "test_user" {
  description = "The test user created for AppStream"
  value       = aws_appstream_user.test_user.user_name
  sensitive   = false
}