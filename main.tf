############################-PROVIDER BLOCK-#######################################

# configure aws provider
provider "aws" {
  access_key = var.access_key #enter your access key here
  secret_key = var.secret_key
  region = var.region
  #profile = "Admin"
}

################################-RESOURCE BLOCK-#########################################

###################################-CREATING EC2 INSTANCES-###################################

#EC2 instance 1
resource "aws_instance" "instance_1_jenkins_manager" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids      = [aws_security_group.dep6_sg_1.id]
  associate_public_ip_address = true  # Enable Auto-assign public IP


  #user_data = "${file("Jenkins.sh")}"
  
  tags = {
    "Name" : "D6_jenkins_manager"
  }

}

#EC2 instance 2

resource "aws_instance" "instance_2_jenkins_agent" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids      = [aws_security_group.dep6_sg_1.id]
  associate_public_ip_address = true  # Enable Auto-assign public IP

  #user_data = "${file("pyt.sh")}"

  tags = {
    "Name" : "D6_jenkins_agent"
  }

}

##################################-SECURITY GROUPS-#######################################

# create security groups

#Security Group 

resource "aws_security_group" "dep6_sg_1" {




  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open for SSH

  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Open for Jenkins web UI

  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  tags = {
    "Name" : "Jenkins_sg"
    "Terraform" : "true"
  }

}


################################-OUTPUT BLOCK-##########################################

output "instance_ip_1" {
  value = aws_instance.instance_1_jenkins_manager.public_ip
}

output "instance_ip_2" {
  value = aws_instance.instance_2_jenkins_agent.public_ip
}
