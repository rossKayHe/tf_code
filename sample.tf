provider "aws" {
    profile = "default"
    region = "us-west-2"
}

resource "aws_s3_bucket" "sample_bucket" {
    bucket = "my-sample-20200711"
    acl = "private"
}