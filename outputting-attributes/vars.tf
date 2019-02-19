variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  default = "us-east-1"
}

variable "AMIS" {
  type = "map"

  default = {
    us-east-1 = "ami-5cd4a126"
    us-west-1 = "ami-e1131781"
    eu-west-1 = "ami-94b236ed"
  }
}
