resource "aws_subnet" "management" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.management_subnet_cidr
  availability_zone       = var.azs[0]
  map_public_ip_on_launch = true
  tags                    = { Name = "management-subnet" }
}

resource "aws_subnet" "app" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.app_subnet_cidrs
  availability_zone       = var.azs[0]
  map_public_ip_on_launch = false
  tags                    = { Name = "app-subnet" }
}

resource "aws_subnet" "backend" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.backend_subnet_cidrs
  availability_zone       = var.azs[1]
  map_public_ip_on_launch = false
  tags                    = { Name = "backend-subnet" }
}