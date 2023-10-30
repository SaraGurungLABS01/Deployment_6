# configure aws provider
provider "aws" {
  access_key = var.aws_access_key 
  secret_key = var.aws_secret_key
  region     = var.region
  #profile = "Admin"
}

################################-RESOURCE BLOCK-#########################################

###################################-CREATING EC2 INSTANCES-###################################

#EC2 instance 1
resource "aws_instance" "bank_app_west" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.dep6_west_sg.id]
  subnet_id                   = aws_subnet.Deployment6_public_subnet1_west.id
  key_name                    = var.key_name
  associate_public_ip_address = true # Enable Auto-assign public IP

 user_data = "${file("appsetup.sh")}"

  tags = {
    "Name" : "Bank_App_West1"
  }

}

#EC2 instance 2

resource "aws_instance" "bank_app2_west" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.dep6_west_sg.id]
  subnet_id                   = aws_subnet.Deployment6_public_subnet2_west.id
  key_name                    = var.key_name
  associate_public_ip_address = true # Enable Auto-assign public IP

 user_data = "${file("appsetup.sh")}"

  tags = {
    "Name" : "Bank_App_West2"
  }

}


######################################-VPC-###############################################

#create vpc

resource "aws_vpc" "Deployment6_VPC_us_west" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Deployment6_VPC_us_west"
  }
}



#######################################-SUBNETS-######################################################

#create 2 subnets

# Subnet-1

resource "aws_subnet" "Deployment6_public_subnet1_west" {
  vpc_id            = aws_vpc.Deployment6_VPC_us_west.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true 

  tags = {
    Name = "Deployment6_public_subnet1_west"
  }
}

#Subnet-2

resource "aws_subnet" "Deployment6_public_subnet2_west" {
  vpc_id            = aws_vpc.Deployment6_VPC_us_west.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "Deployment6_public_subnet2_west"
  }
}

##################################-SECURITY GROUPS-#######################################

# create security groups

#Security Group 

resource "aws_security_group" "dep6_west_sg" {
  vpc_id = aws_vpc.Deployment6_VPC_us_west.id


  ingress {
    description = "allow incoming SSH traffic"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow incoming traffic on port 8080"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }



  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


  tags = {
    "Name" : "dep6_west_sg"
    "Terraform" : "true"
  }

}

#############################-INTERNET GATEWAY-####################################

#create internet gateway

resource "aws_internet_gateway" "Dep6_west_gw" {
  vpc_id = aws_vpc.Deployment6_VPC_us_west.id

  tags = {
    Name = "IGW_D6_west"
  }
}

#############################- ROUTE TABLE-######################################

#create route table


resource "aws_default_route_table" "Dep6_west_RT" {
  default_route_table_id = aws_vpc.Deployment6_VPC_us_west.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Dep6_west_gw.id
  }
}




################################-OUTPUT BLOCK-##########################################

output "instance_ip_1" {
  value = aws_instance.bank_app_west.public_ip
}

output "instance_ip_2" {
  value = aws_instance.bank_app2_west.public_ip
}
