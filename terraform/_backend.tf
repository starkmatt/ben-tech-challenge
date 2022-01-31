terraform {
    backend "s3"{
        bucket = "starkmatt-s3"
        key = "ben-tech-challenge/tfstatefiles"
        region = "ap-southeast-2"
    }
}