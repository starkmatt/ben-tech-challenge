appname = "ben-tech-challenge"
environment = "local"
region = "ap-southeast-2"
profile = "default"
cidr = "10.0.0.0/24"
private1Cidr = "10.0.0.0/26"
private2Cidr = "10.0.0.64/26"
public1Cidr = "10.0.0.128/26"
public2Cidr = "10.0.0.192/26"
containerPort = 80
albPort = 80
availabilityZoneA = "ap-southeast-2a"
availabilityZoneB = "ap-southeast-2b"
dockerRepo = "starkmatt/make01"
cpu = 256
memory = 512
publicIp = true