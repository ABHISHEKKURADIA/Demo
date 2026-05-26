terraform{
    required_providers{
        aws={
            source="hashicorp/aws"
            version="~> 5.92"
        }
    }
    required_version=">= 1.2"
}

provider "aws" {
    region = "ap-south-1"
}

resource "aws_vpc" "custom_vpc" {
    cidr_block = "15.4.0.0/16"
    tags = {
        Name = "custom_vpc"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.custom_vpc.id
    cidr_block = "15.4.1.0/24"
    tags = {
        Name = "public_subnet"
    }
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.custom_vpc.id
    cidr_block = "15.4.2.0/24"
    tags = {
        Name = "private_subnet"
    }
}

resource "aws_internet_gateway" "myIGW" {
    vpc_id= aws_vpc.custom_vpc.id
}

resource "aws_route_table" "publicRouteTable" {
    vpc_id = aws_vpc.custom_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myIGW.id
    }
    tags = {
        Name = "publicRouteTable"
    }
}

resource "aws_route_table_association" "publicRouteTableAssociation" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.publicRouteTable.id
}




