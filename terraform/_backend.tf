terraform {
    backend "s3"{
        bucket = "starkmatt-s3"
        key = "ben-tech-challenge/tfstatefile"
        region = "ap-southeast-2"
    }
}