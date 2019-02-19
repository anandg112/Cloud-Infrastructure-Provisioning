resource "aws_iam_role" "ssm_role" {
  name = "ssm_role"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": {
      "Effect": "Allow",
      "Principal": {"Service": "ssm.amazonaws.com"},
      "Action": "sts:AssumeRole"
    }
  }
EOF
}

resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role       = "${aws_iam_role.ssm_role.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_ssm_activation" "activate-ec2" {
  name               = "ec2_ssm_activation"
  description        = "activate SSM for EC2 instances"
  iam_role           = "${aws_iam_role.ssm_role.id}"
  registration_limit = "5"
  depends_on         = ["aws_iam_role_policy_attachment.ssm_attach"]
}

resource "aws_ssm_document" "shell_script_runner" {
  name          = "shell_script_document"
  document_type = "Command"

  content = <<DOC
{
    "schemaVersion": "1.2",
    "description": "Check ip configuration of a Linux instance.",
    "parameters": {

    },
    "runtimeConfig": {
      "aws:runShellScript": {
        "properties": [
          {
            "id": "0.aws:runShellScript",
            "runCommand": ["ifconfig"]
          }
        ]
      }
    }
  }
DOC
}

resource "aws_ssm_association" "ec2_assoc" {
  name = "${aws_ssm_document.shell_script_runner.name}"

  targets {
    key    = "InstanceIds"
    values = ["${aws_instance.web.id}"]
  }
}
