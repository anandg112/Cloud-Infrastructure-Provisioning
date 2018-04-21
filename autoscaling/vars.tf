variable "AWS_REGION" {
  default = "us-east-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "mykey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "mykey.pub"
}

variable "AMIS" {
  type = "map"

  default = {
    us-east-1 = "ami-58deab22"
    us-west-1 = "ami-32131752"
    eu-west-1 = "ami-bdb83cc4"
  }
}
