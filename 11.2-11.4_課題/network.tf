resource "aws_vpc" "vpc" {
    cidr_block = "10.1.0.0/16"
    instance_tenancy = "default"

    tags = {
      Name = "hirayama-test-vpc"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = "aws_vpc.vpc.id"
    cidr_block = "10.1.10.0/24"
    availability_zone = "ap-northeast-1a"

    tags{
        Name = "hirayama-test-PnublicSubnet-1a"
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = "aws_vpc.vpc.id"
    cidr_block = "10.1.110.0/24"
    availability_zone = "ap-northeast-1a"

    tags{
        Name = "hirayama-test-PrivateSubnet-1a"
    }
}

resource "aws_internet_gateway" "internet_gateway" {
    vpc_id = aws_vpc.vpc.id
}

resouce "aws_route_table" "public" {
    vpc_id = "aws_vpc.vpc.id"
}

resouce "aws_route" "public" {
    route_table_id = "aws_route_table.public.id"
    gateway_id = "aws_internet_gateway.internet_gateway.id"
    destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "public"{
    subnet_id = "aws_subnet.public_subnet.id"
    route_table_id = "aws_route_table.public.id"
}

resouce "aws_route_table" "private" {
    vpc_id = "aws_vpc.vpc.id"
}

resource "aws_route_table_association" "private"{
    subnet_id = "aws_subnet.private_subnet.id"
    route_table_id = "aws_route_table.private.id"
}

resource "aws_eip" "nat_gateway" {
    vpc = "true"
    depeonds_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_nat_gateway" "nat_gateway" {
    allocation_id = "aws_eip.nat_gateway.id"
    subnet_id = "aws_subnet.public_subnet.id
    depends_on = [aws_internet_gateway.internet_gateway]
}

resource "aws_route" "private" {
    route_table_id = "aws_route_table.private.id"
    nat_gateway_id = "aws_nat_gateway.nat_gateway.id"
    destination_cidr_block = "0.0.0.0/0"
}
