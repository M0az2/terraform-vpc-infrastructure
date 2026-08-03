resource "aws_route_table" "public_rt" {

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = var.internet_cidr

    gateway_id = aws_internet_gateway.igw.id

  }

  tags = {
    Name = "${var.project_name}-public-route-table"
  }
}


resource "aws_route_table_association" "public_assoc_1" {

  subnet_id = aws_subnet.public_subnet_1.id

  route_table_id = aws_route_table.public_rt.id

}


resource "aws_route_table_association" "public_assoc_2" {

  subnet_id = aws_subnet.public_subnet_2.id

  route_table_id = aws_route_table.public_rt.id

}




resource "aws_route_table" "private_rt" {

  vpc_id = aws_vpc.main.id

  route {

    cidr_block = var.internet_cidr

    nat_gateway_id = aws_nat_gateway.nat.id

  }

  tags = {
    Name = "${var.project_name}-private-route-table"
  }

}




resource "aws_route_table_association" "private_assoc_1" {

  subnet_id = aws_subnet.private_subnet_1.id

  route_table_id = aws_route_table.private_rt.id

}



resource "aws_route_table_association" "private_assoc_2" {

  subnet_id = aws_subnet.private_subnet_2.id

  route_table_id = aws_route_table.private_rt.id

}