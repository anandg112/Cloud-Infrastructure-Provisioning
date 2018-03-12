resource "aws_key_pair" "mykeypair2" {
  key_name = "mykeypair2"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}

