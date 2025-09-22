provider "aws" {
    region = "us-east-2" 
}

resource "aws_instance" "example" {
    ami           = "ami-06a974f9b8a97ecf2" # Update this with a valid AMI ID
    instance_type = "t2.micro"
    tags = {
        Name = "OpenTofu-Instance"
    }
}