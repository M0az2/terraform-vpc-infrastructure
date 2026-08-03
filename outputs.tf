# VPC ID

output "vpc_id" {

  description = "VPC ID"

  value = aws_vpc.main.id

}



# Internet Gateway ID

output "internet_gateway_id" {

  description = "Internet Gateway ID"

  value = aws_internet_gateway.igw.id

}



# NAT Gateway ID

output "nat_gateway_id" {

  description = "NAT Gateway ID"

  value = aws_nat_gateway.nat.id

}



# Public Subnet IDs

output "public_subnet_ids" {

  description = "Public Subnet IDs"

  value = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]

}



# Private Subnet IDs

output "private_subnet_ids" {

  description = "Private Subnet IDs"

  value = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]

}



# Public Route Table ID

output "public_route_table_id" {

  description = "Public Route Table ID"

  value = aws_route_table.public_rt.id

}



# Private Route Table ID

output "private_route_table_id" {

  description = "Private Route Table ID"

  value = aws_route_table.private_rt.id

}