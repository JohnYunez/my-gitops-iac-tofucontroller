provider "aws" {
    region = "us-east-2" 
}

resource "aws_instance" "example" {
    ami           = "ami-0ca4d5db4872d0c28" # Amazon Linux 2 AMI #us-east-2
    instance_type = "t2.micro"
    tags = {
        Name = "observabilidad"
    }
}
