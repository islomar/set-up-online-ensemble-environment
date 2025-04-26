# AWS AppStream 2.0 Terraform Module

This Terraform module deploys AWS AppStream 2.0 resources to provide application streaming capabilities. It creates an AppStream fleet, stack, and the necessary networking infrastructure.

## Architecture

This module sets up the following AWS resources:

- AppStream 2.0 Fleet: Virtual machines that run the streaming applications
- AppStream 2.0 Stack: The interface through which users access the applications
- VPC, Subnets, Internet Gateway, Route Tables (optional): Networking infrastructure for the AppStream fleet
- Security Group: Controls network traffic to and from the AppStream instances
- Test User: A sample user for testing the AppStream environment

## Prerequisites

- AWS account with appropriate permissions
- Terraform v1.2.0 or newer
- AWS CLI configured with appropriate credentials

## Usage

```hcl
module "appstream" {
  source = "./terraform/aws-appstream"

  aws_region          = "us-west-2"
  environment         = "dev"
  appstream_fleet_name = "my-appstream-fleet"
  appstream_stack_name = "my-appstream-stack"
  instance_type       = "stream.standard.medium"
  fleet_type          = "ON_DEMAND"
  
  # Optional: Provide existing VPC and subnet IDs
  # vpc_id     = "vpc-12345678"
  # subnet_ids = ["subnet-12345678", "subnet-87654321"]
}
```

## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| aws_region | The AWS region to deploy resources | string | "us-west-2" | no |
| environment | Environment name (e.g., dev, staging, prod) | string | "dev" | no |
| appstream_fleet_name | Name of the AppStream fleet | string | "appstream-fleet" | no |
| appstream_stack_name | Name of the AppStream stack | string | "appstream-stack" | no |
| appstream_image_name | Name of the AppStream image to use | string | "AppStream-WinServer2019-07-11-2023" | no |
| instance_type | The instance type for the AppStream fleet | string | "stream.standard.medium" | no |
| fleet_type | The fleet type (ALWAYS_ON or ON_DEMAND) | string | "ON_DEMAND" | no |
| max_user_duration_in_seconds | The maximum time that a streaming session can remain active | number | 57600 (16 hours) | no |
| disconnect_timeout_in_seconds | The amount of time that a streaming session remains active after users disconnect | number | 900 (15 minutes) | no |
| idle_disconnect_timeout_in_seconds | The amount of time that users can be idle before they are disconnected | number | 900 (15 minutes) | no |
| vpc_id | The ID of the VPC to deploy AppStream resources | string | "" | no |
| subnet_ids | The IDs of the subnets to deploy AppStream resources | list(string) | [] | no |

## Outputs

| Name | Description |
|------|-------------|
| appstream_fleet_arn | The ARN of the AppStream fleet |
| appstream_stack_arn | The ARN of the AppStream stack |
| appstream_stack_access_endpoints | The access endpoints for the AppStream stack |
| vpc_id | The ID of the VPC used for AppStream resources |
| subnet_ids | The IDs of the subnets used for AppStream resources |
| security_group_id | The ID of the security group used for AppStream resources |
| test_user | The test user created for AppStream |

## Customization

### Active Directory Integration

To integrate with Active Directory, uncomment and configure the `aws_appstream_directory_config` resource and the `domain_join_info` block in the AppStream fleet resource.

### Custom Images

To use a custom AppStream image, update the `appstream_image_name` variable with the name of your custom image.

## Notes

- The default configuration creates a new VPC with two subnets in different availability zones.
- If you provide existing VPC and subnet IDs, the module will use those instead of creating new ones.
- The test user is created in the AppStream user pool for demonstration purposes.

## License

This module is licensed under the MIT License.