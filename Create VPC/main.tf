provider "aws" {
  region = "us-east-1"
}
# Creating VPC, name, CIDR and tags
resource "aws_vpc" "dev" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "dev"
  }
}

# Creating public subnet
resource "aws_subnet" "dev-public-1" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1a"
  tags = {
    Name = "dev-public-1"
  }
}

resource "aws_subnet" "dev-public-2" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1b"
  tags = {
    Name = "dev-public-2"
  }
}

#Creating internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.dev.id
  tags = {
    Name = "dev"
  }
}

#Creating route table
resource "aws_route_table" "dev-table" {
  vpc_id = aws_vpc.dev.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "dev-table"
  }
}

#Create route table assosiation
resource "aws_route_table_association" "dev-public-1-a" {
  subnet_id      = aws_subnet.dev-public-1.id
  route_table_id = aws_route_table.dev-table.id
}
resource "aws_route_table_association" "dev-public-2-a" {
  subnet_id      = aws_subnet.dev-public-2.id
  route_table_id = aws_route_table.dev-table.id
}

# Create EC2 instances in public subnet
resource "aws_instance" "public_inst_1" {
  ami = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.dev-public-1.id}"
  key_name = "testkey"
  tags = {
    Name = "public_inst_1"
  }
}
resource "aws_instance" "public_inst_2" {
  ami = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.dev-public-2.id}"
  key_name = "testkey"
  tags = {
    Name = "public_inst_2"
  }
}