# main.tf

terraform {
required_version = ">= 1.5"

required_providers {
aws = {
source  = "hashicorp/aws"
version = "~> 5.0"
}
}
}

provider "aws" {
region = var.aws_region
}


data "aws_ami" "amazon_linux" {
most_recent = true

owners = ["amazon"]

filter {
name   = "name"
values = ["al2023-ami-*-x86_64"]
}
}

resource "aws_security_group" "lamp_sg" {
name        = "lamp-security-group"
description = "Allow HTTP HTTPS and SSH"

ingress {
description = "SSH"
from_port   = 22
to_port     = 22
protocol    = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
description = "HTTP"
from_port   = 80
to_port     = 80
protocol    = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}

ingress {
description = "HTTPS"
from_port   = 443
to_port     = 443
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
Owner = var.owner_name
}
}

resource "aws_instance" "lamp_server" {
ami                    = data.aws_ami.amazon_linux.id
instance_type          = var.instance_type
key_name               = var.key_name
vpc_security_group_ids = [aws_security_group.lamp_sg.id]

root_block_device {
volume_size = 20
volume_type = "gp3"
}

user_data = <<-EOF
#!/bin/bash
dnf update -y

# Install Apache

dnf install -y httpd

# Install PHP

dnf install -y php php-mysqlnd

# Install MariaDB

dnf install -y mariadb105-server

systemctl enable httpd
systemctl start httpd

systemctl enable mariadb
systemctl start mariadb

echo "<h1>LAMP Stack Deployed</h1><p>Owner: ${var.owner_name}</p>" > /var/www/html/index.html
EOF

tags = {
Name  = "lamp-server"
Owner = var.owner_name
}
}

output "public_ip" {
value = aws_instance.lamp_server.public_ip
}

output "owner" {
value = var.owner_name
}
