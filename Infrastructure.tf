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

resource "aws_security_group" "customSG" {
    name = "customSG"
    vpc_id = aws_vpc.custom_vpc.id
    ingress {
        from_port  = 0
        to_port    = 0
        protocol   = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
}


resource "aws_instance" "web_server" {
    ami = "ami-07a00cf47dbbc844c"
    instance_type = "t2.medium"
    subnet_id = aws_subnet.public_subnet.id
    security_groups = [aws_security_group.customSG.name]
    tags = {
        Name = "web_server"
    }
    user_data = <<-EOF
                #!/bin/bash
                sudo apt update -y
                sudo apt install docker.io -y
                sudo systemctl start docker
                sudo systemctl enable docker
                sudo apt update -y
                sudo apt update
                sudo apt install fontconfig openjdk-21-jre
                java -version
                sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
                https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
                echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
                https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
                /etc/apt/sources.list.d/jenkins.list > /dev/null
                sudo apt update
                sudo apt install jenkins -y
                sudo systemctl start jenkins
                sudo systemctl enable jenkins
            EOF
}
