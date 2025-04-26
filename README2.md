# AWS AppStream 2.0 Terraform Project

This project contains Terraform code to deploy AWS AppStream 2.0 resources for application streaming. It was created in response to the requirements described in the blog post ["Smooth Ensemble with AWS AppStream: How-to Guide"](https://coding-is-like-cooking.info/2025/04/smooth-ensemble-with-aws-appstream-how-to-guide/).

## Project Structure

- [`aws-appstream/`](./aws-appstream/): Terraform module for deploying AWS AppStream 2.0 resources

## Getting Started

1. Navigate to the `aws-appstream` directory:
   ```bash
   cd terraform/aws-appstream
   ```

2. Initialize the Terraform working directory:
   ```bash
   terraform init
   ```

3. Create a `terraform.tfvars` file with your specific configuration:
   ```hcl
   aws_region          = "us-west-2"
   environment         = "dev"
   appstream_fleet_name = "my-appstream-fleet"
   appstream_stack_name = "my-appstream-stack"
   ```

4. Review the execution plan:
   ```bash
   terraform plan
   ```

5. Apply the changes:
   ```bash
   terraform apply
   ```

6. When you're done, you can destroy the resources:
   ```bash
   terraform destroy
   ```

## Module Documentation

For detailed information about the AWS AppStream 2.0 Terraform module, see the [module README](../../../set-up-online-ensemble-environment/README.md).

## License

This project is licensed under the MIT License.