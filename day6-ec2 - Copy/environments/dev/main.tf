provider "aws" {
  region = "ap-south-1"
}
module "vpc" {
    source = "../../modules/vpc"
    cidr_block = "10.0.0.0/16"
    environment = "dev"
    availability_zone = "ap-south-1a"
}
module "ec2" {
  source = "../../modules/ec2"
  vpc_id = module.vpc.vpc_id
  subnet_id = module.vpc.subnet_id
  environment = "dev"
  intance_type = "t2.micro"
}