provider "aws" {
    region = "us-east-2" 
}

resource "aws_instance" "instance" {
    ami           = "ami-0ca4d5db4872d0c28" # Amazon Linux 2 AMI #us-east-2
    instance_type = "t2.micro"
    tags = {
        Name = "my-gitops-instance"
        Source = "git:my-gitops-iac-tofucontroller"
        appcode = "nu0000000"
    }
}

output "instance_id" {
    value = aws_instance.instance.id
}
