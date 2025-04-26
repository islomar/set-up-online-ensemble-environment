variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-west-2"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "appstream_fleet_name" {
  description = "Name of the AppStream fleet"
  type        = string
  default     = "appstream-fleet"
}

variable "appstream_stack_name" {
  description = "Name of the AppStream stack"
  type        = string
  default     = "appstream-stack"
}

variable "appstream_image_name" {
  description = "Name of the AppStream image to use"
  type        = string
  default     = "AppStream-WinServer2019-07-11-2023"
}

variable "instance_type" {
  description = "The instance type for the AppStream fleet"
  type        = string
  default     = "stream.standard.medium"
}

variable "fleet_type" {
  description = "The fleet type (ALWAYS_ON or ON_DEMAND)"
  type        = string
  default     = "ON_DEMAND"
}

variable "max_user_duration_in_seconds" {
  description = "The maximum time that a streaming session can remain active"
  type        = number
  default     = 57600  # 16 hours
}

variable "disconnect_timeout_in_seconds" {
  description = "The amount of time that a streaming session remains active after users disconnect"
  type        = number
  default     = 900  # 15 minutes
}

variable "idle_disconnect_timeout_in_seconds" {
  description = "The amount of time that users can be idle before they are disconnected"
  type        = number
  default     = 900  # 15 minutes
}

variable "vpc_id" {
  description = "The ID of the VPC to deploy AppStream resources"
  type        = string
  default     = ""
}

variable "subnet_ids" {
  description = "The IDs of the subnets to deploy AppStream resources"
  type        = list(string)
  default     = []
}