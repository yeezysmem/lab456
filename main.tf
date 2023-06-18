terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "eu-north-1"
}

resource "aws_instance" "lab6_my" {
  ami           = "ami-0989fb15ce71ba39e"
  instance_type = "t3.micro"
  key_name = "key2"
  security_groups = [aws_security_group.Lab6_SGroupe.name]

  user_data = "${file("init.sh")}"

  tags = {
    Name = "Lab 6 Instance"
  }
}

resource "aws_security_group" "Lab6_SGroupe" {
  name        = "Lab 6 Security Group"
  description = "Lab 6 Security Group"
  vpc_id      = "vpc-0a514b4ea2d4dbdd5"

  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Lab6_SGroupe"
  }
}