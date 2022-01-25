terraform {
    backend "s3"{
        bucket = "snitch-tf-state-bucket"
        key = "ben-tech-challenge/tfstatefiles"
        region = "ap-southeast-2"
    }
}