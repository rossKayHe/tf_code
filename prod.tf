provider "aws {
    profile =  "default"
    region  = "us-west-2"
}

resource "aws_s3_bucket" "prod_tf_sample" { 
    bucket = "tf-sample-20200712"
    acl    = "private"
}

resouce "aws_default_vpc" "default" {}

resource "aws_security_group" "prod_web"  {
    name        = "prod_web"
    description = "Allow standard http and https ports inbound and everything outbound"

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
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
        "Terraform" : "true"
    }
}
resource "aws_instance" " prod_web" {
    count = 2

    ami           = "ami-01ebd27ddd89835f4"
    instance_type = t2.nano

    vpc_security_group_ids = [
        aws_security_group.web.id
    ]

    tags = {
        "Terraform" : "true"
    }
} 

resource "aws_eip_asociation" "prod_web" {
    instance_id = aws_instance.prod_web.0.id
    allocation_id = aws.eip.prod_web.id
}

resource "aws_eip" "prod_web" {
    tags = {
        "Terraform" : "true"
    }
}