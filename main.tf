provider "aws" {
    region = "ap-southeast-1"
}

resource "aws_instance" "test-ec2" {
    ami = "ami-003c463c8207b4dfa"     # ubuntu

    instance_type = "t2.micro"
    vpc_security_group_ids = [aws_security_group.instance.id]

    user_data = <<-EOF
                #!/bin/bash
                echo "Hello Arjun" > index.html
                nohup busybox httpd -f -p 8080 &
                EOF

    user_data_replace_on_change = true

    tags = {
        Name = "Simple webserver with terrafrom on ec2"
    }
  
}


resource "aws_security_group" "instance" {
    name = var.security_group_name
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}

variable "security_group_name" {
  description = "The name of the security group"
  type        = string
  default     = "terraform-test-instance"
}

output "public_ip" {
  value       = aws_instance.test-ec2.public_ip
  description = "The public IP of the Instance"
}

