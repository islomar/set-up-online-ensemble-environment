<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents** *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [AWS AppStream 2.0 Terraform Project](#aws-appstream-20-terraform-project)
  - [Project Structure](#project-structure)
  - [Getting Started](#getting-started)
  - [Module Documentation](#module-documentation)
  - [License](#license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# AWS AppStream 2.0 Terraform Project

This project contains Terraform code to deploy AWS AppStream 2.0 resources for application streaming.
It was created in response to the requirements described in the blog post ["Smooth Ensemble with AWS AppStream: How-to Guide"](https://coding-is-like-cooking.info/2025/04/smooth-ensemble-with-aws-appstream-how-to-guide/).

## Project Structure

- [`main.tf`](./main.tf) and the other `.tf` files at the repository root: Terraform module for deploying AWS AppStream 2.0 resources

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
   aws_region          = "eu-south-2"
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

For detailed information about the AWS AppStream 2.0 Terraform module, see the [module README](./README.md).

## License

This project is licensed under the MIT License.
