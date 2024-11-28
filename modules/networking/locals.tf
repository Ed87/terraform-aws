locals {
  all_vpc_route_table_ids    = flatten([aws_route_table.orion-private-rt[*].id, aws_route_table.orion-public-rt[*].id])
  all_vpc_private_subnet_ids = flatten([aws_subnet.orion-private-subnet[*].id])
  vpc_name                   = "VPC-A"
  vpc_gateway_endpoints = {
    service_name = {
      s3       = join(".", ["com.amazonaws", var.aws_region, "s3"]),
      dynamodb = join(".", ["com.amazonaws", var.aws_region, "dynamodb"])
    }
  }
}