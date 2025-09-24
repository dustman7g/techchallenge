resource "aws_subnet" "management" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.management_subnet_cidr
  availability_zone       = var.azs[0]
  map_public_ip_on_launch = true
  tags                    = { Name = "management-subnet" }
}

resource "aws_subnet" "app" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + 2)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false
  tags = { Name = "app-subnet-${count.index}" }
}

resource "aws_subnet" "backend" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.backend_subnet_cidrs
  availability_zone       = var.azs[1]
  map_public_ip_on_launch = false
  tags                    = { Name = "backend-subnet" }
}