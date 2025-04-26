# Local variables
locals {
  # Use provided VPC and subnet IDs or create new ones
  create_vpc = var.vpc_id == "" ? true : false
  vpc_id     = local.create_vpc ? aws_vpc.appstream_vpc[0].id : var.vpc_id
  subnet_ids = length(var.subnet_ids) > 0 ? var.subnet_ids : aws_subnet.appstream_subnet[*].id
}

# VPC resources (only created if vpc_id is not provided)
resource "aws_vpc" "appstream_vpc" {
  count      = local.create_vpc ? 1 : 0
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "appstream-vpc"
  }
}

resource "aws_subnet" "appstream_subnet" {
  count             = local.create_vpc ? 2 : 0
  vpc_id            = local.vpc_id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = "${var.aws_region}${count.index == 0 ? "a" : "b"}"
  
  tags = {
    Name = "appstream-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "appstream_igw" {
  count  = local.create_vpc ? 1 : 0
  vpc_id = local.vpc_id
  
  tags = {
    Name = "appstream-igw"
  }
}

resource "aws_route_table" "appstream_rt" {
  count  = local.create_vpc ? 1 : 0
  vpc_id = local.vpc_id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.appstream_igw[0].id
  }
  
  tags = {
    Name = "appstream-rt"
  }
}

resource "aws_route_table_association" "appstream_rta" {
  count          = local.create_vpc ? 2 : 0
  subnet_id      = aws_subnet.appstream_subnet[count.index].id
  route_table_id = aws_route_table.appstream_rt[0].id
}

resource "aws_security_group" "appstream_sg" {
  name        = "appstream-security-group"
  description = "Security group for AppStream resources"
  vpc_id      = local.vpc_id
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "appstream-sg"
  }
}

# AppStream Directory Config (optional)
# Uncomment if you need to integrate with Active Directory
# resource "aws_appstream_directory_config" "appstream_directory" {
#   directory_name                          = "corp.example.com"
#   organizational_unit_distinguished_names = ["OU=AppStream,DC=corp,DC=example,DC=com"]
#   service_account_credentials {
#     account_name     = "service_account_name"
#     account_password = "service_account_password"
#   }
# }

# AppStream Fleet
resource "aws_appstream_fleet" "appstream_fleet" {
  name                            = var.appstream_fleet_name
  instance_type                   = var.instance_type
  fleet_type                      = var.fleet_type
  image_name                      = var.appstream_image_name
  max_user_duration_in_seconds    = var.max_user_duration_in_seconds
  disconnect_timeout_in_seconds   = var.disconnect_timeout_in_seconds
  idle_disconnect_timeout_in_seconds = var.idle_disconnect_timeout_in_seconds
  
  compute_capacity {
    desired_instances = 1
  }
  
  vpc_config {
    subnet_ids         = local.subnet_ids
    security_group_ids = [aws_security_group.appstream_sg.id]
  }
  
  # Uncomment if you need to integrate with Active Directory
  # domain_join_info {
  #   directory_name = "corp.example.com"
  #   organizational_unit_distinguished_name = "OU=AppStream,DC=corp,DC=example,DC=com"
  # }
  
  depends_on = [
    aws_subnet.appstream_subnet,
    aws_security_group.appstream_sg
  ]
}

# AppStream Stack
resource "aws_appstream_stack" "appstream_stack" {
  name         = var.appstream_stack_name
  description  = "AppStream stack for streaming applications"
  display_name = "Application Streaming"
  
  storage_connectors {
    connector_type = "HOMEFOLDERS"
  }
  
  user_settings {
    action     = "CLIPBOARD_COPY_FROM_LOCAL_DEVICE"
    permission = "ENABLED"
  }
  
  user_settings {
    action     = "CLIPBOARD_COPY_TO_LOCAL_DEVICE"
    permission = "ENABLED"
  }
  
  user_settings {
    action     = "FILE_DOWNLOAD"
    permission = "ENABLED"
  }
  
  user_settings {
    action     = "FILE_UPLOAD"
    permission = "ENABLED"
  }
  
  user_settings {
    action     = "PRINTING_TO_LOCAL_DEVICE"
    permission = "ENABLED"
  }
  
  application_settings {
    enabled        = true
    settings_group = "AppSettings"
  }
}

# Associate Fleet with Stack
resource "aws_appstream_fleet_stack_association" "appstream_association" {
  fleet_name = aws_appstream_fleet.appstream_fleet.name
  stack_name = aws_appstream_stack.appstream_stack.name
}

# Optional: Create AppStream user (for testing)
resource "aws_appstream_user" "test_user" {
  authentication_type = "USERPOOL"
  user_name           = "test.user@example.com"
  first_name          = "Test"
  last_name           = "User"
}

# Optional: Associate user with stack
resource "aws_appstream_user_stack_association" "test_user_association" {
  stack_name  = aws_appstream_stack.appstream_stack.name
  user_name   = aws_appstream_user.test_user.user_name
  send_email_notification = true
  authentication_type     = "USERPOOL"
}