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

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    owner = "${var.owner}"
    team  = "${var.team}"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id     = "${aws_vpc.my_vpc.id}"
  cidr_block = "10.0.1.0/24"

  tags = {
    owner = "${var.owner}"
    team  = "${var.team}"
  }
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${aws_vpc.my_vpc.id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["142.117.37.207/32"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami                    = "${data.aws_ami.amazon-linux-2.id}"
  instance_type          = "t2.small"
  key_name               = "${var.key_name}"
  subnet_id              = "${aws_subnet.my_subnet.id}"
  vpc_security_group_ids = ["${var.aws_security_group.id}"]

  tags = {
    owner = "${var.owner}"
    team  = "${var.team}"
  }
}
