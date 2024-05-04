provider "aws" {
    region = "ap-southeast-1"
}

resource "aws_instance" "test-ec2" {
    ami = "ami-09b1e8fc6368b8a3a"
    instance_type = "t2.micro"
  
}