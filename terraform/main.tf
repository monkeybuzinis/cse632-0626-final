provider "aws" {
   region = var.region
}

data "aws_ami" "amazon_linux" {
   most_recent = true
   owners      = ["amazon"]
   filter {
     name   = "name"
     values = ["al2023-ami-*-x86_64"]
   }
}

resource "aws_security_group" "cse632_sg" {
   name        = "cse632-sg"
   description = "Allow SSH and HTTP"

   ingress {
     from_port   = 22
     to_port     = 22
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }

   ingress {
     from_port   = 80
     to_port     = 80
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }

   exclude_default_egress = false
   egress {
     from_port   = 0
     to_port     = 0
     protocol    = "-1"
     cidr_blocks = ["0.0.0.0/0"]
   }
}

resource "aws_instance" "cse632_vm" {
   ami                    = data.aws_ami.amazon_linux.id
   instance_type          = var.instance_type
   key_name               = var.key_name
   vpc_security_group_ids = [aws_security_group.cse632_sg.id]

   # Automatically installs NGINX and sets up your index.html file
   user_data = <<-INPUT_EOF
              #!/bin/bash
              dnf update -y
              dnf install nginx -y
              cat << 'HTML_EOF' > /usr/share/nginx/html/index.html
              $(cat ../index.html)
              HTML_EOF
              systemctl enable nginx
              systemctl start nginx
              INPUT_EOF

   tags = {
     Name    = "cse632-nginx-server"
     Project = "cse632-0626-final"
   }
}
