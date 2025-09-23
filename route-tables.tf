# Public route table (management subnet) with IGW
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = { Name = "public-rt" }
}

resource "aws_route_table_association" "mgmt_assoc" {
  subnet_id      = aws_subnet.management.id
  route_table_id = aws_route_table.public.id
}

# Private route table for app & backend using NAT
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }

  tags = { Name = "private-rt" }
}

resource "aws_route_table_association" "app_assoc" {
  count          = length(aws_subnet.app)
  subnet_id      = aws_subnet.app[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "backend_assoc" {
  count          = length(aws_subnet.backend)
  subnet_id      = aws_subnet.backend[count.index].id
  route_table_id = aws_route_table.private.id
}