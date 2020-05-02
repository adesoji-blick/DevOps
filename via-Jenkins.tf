provider "aws" {
  profile    = "default"
  region     = "ca-central-1"
}

resource "aws_instance" "blick-stage" {

    ami             = "ami-021321e9bc16d5186"
    key_name         = "blick-devops"
    instance_type    = "t2.micro"
    subnet_id       = "subnet-09470e94c33ebd976"
    count            = 1


    tags = {
        Name = "Blick-stage${count.index + 1}"
        Creator = "blick-admin"
    }
}
terraform {

backend "s3" {
    bucket  = "blick-tfstate"
    key     = "state5"
    region  = "ca-central-1"
    }
}

output "public_ip" {
  value = ["${aws_instance.blick-stage.*.public_ip}"]
}