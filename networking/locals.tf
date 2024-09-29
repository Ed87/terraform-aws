locals {
    all_vpc_route_table_ids = flatten([aws_route_table.orion-private-rt[*].id, aws_route_table.orion-public-rt[*].id])
}