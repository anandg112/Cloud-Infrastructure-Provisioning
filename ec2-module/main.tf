provider "aws" {
  region = "${var.region}"
}

data "aws_ami" "amazon-linux-2" {
  most_recent = true

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_instance" "web" {
  ami           = "${data.aws_ami.amazon-linux-2.id}"
  instance_type = "t2.small"
  key_name      = "${var.key_name}"

  tags = {
    owner = "${var.owner}"
    team  = "${var.team}"
  }
}
