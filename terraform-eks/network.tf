data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.app_name}-vpc"]
  }
}

data "aws_route_table" "rt" {
  vpc_id = data.aws_vpc.vpc.id

  filter {
    name   = "tag:Name"
    values = ["${var.app_name}-route-table"]
  }
}

data "aws_subnet" "public_subnet1" {
  filter {
    name   = "tag:Name"
    values = ["${var.app_name}-public-subnet"]
  }
}

data "aws_security_group" "security_group" {
  filter {
    name   = "tag:Name"
    values = ["${var.app_name}-sg"]
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id                  = data.aws_vpc.vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.app_name}-public-subnet2"
  }
}

resource "aws_route_table_association" "rt-association" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = data.aws_route_table.rt.id
}