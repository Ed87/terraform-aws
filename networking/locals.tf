locals {
  all_vpc_route_table_ids = flatten([aws_route_table.orion-private-rt[*].id, aws_route_table.orion-public-rt[*].id])
  vpc_gateway_endpoints = {
    service_name = {
      s3       = join(".", ["com.amazonaws", data.aws_region.current.name, "s3"]),
      dynamodb = join(".", ["com.amazonaws", data.aws_region.current.name, "dynamodb"])
    }
  }
}