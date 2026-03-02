provider "aws" {
    region = "us-east-2" 
}

resource "aws_instance" "instance" {
    ami           = "ami-0ca4d5db4872d0c28" # Amazon Linux 2 AMI #us-east-2  //ami-058e74ab207ed2b33
    instance_type = "t2.micro"
    tags = {
        Name = "my-gitops-instance"
        "gitops:source" = "git:my-gitops-iac-tofucontroller"
        "bancolombia:application-code" = "nu0445004"
        "bancolombia:project-name" = "kaizen-tofucontroller"
        "bancolombia:env" = "sbx"
    }
}

output "instance_id" {
    value = aws_instance.instance.id
}
