output "image_id" {
  value = "${data.aws_ami.amazon-linux-2.image_id}"
}

output "instance_id" {
  value = "${aws_instance.web.id}"
}

output "instance_arn" {
  value = "${aws_instance.web.arn}"
}
