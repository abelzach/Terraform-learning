# Create VPC
resource "aws_vpc" "test_vpc" {
  cidr_block       = "10.0.0.0/18"

  tags = {
    Name = "test VPC"
  }
}

# Create public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1a"
  tags = {
    Name = "public_subnet"
  }
}

# Create private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.test_vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-1a"
  tags = {
    Name = "private_subnet"
  }
}

# Creating internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "Test Gateway"
  }
}

# Create route table for public subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Public Route tbale"
  }
}

# Route table association between public subnet and public route table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

