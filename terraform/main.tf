terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

resource "aws_s3_bucket" "b" {
  bucket = "snitch-tf-test"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "local"
  }
}