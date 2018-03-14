#group definition
resource "aws_iam_group" "admin" {
  name = "admin"
}

resource "aws_iam_policy_attachment" "admin-attach" {
  name       = "admin-attach"
  groups     = ["${aws_iam_group.admin.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

#user
resource "aws_iam_user" "admin1" {
  name = "admin1"
}

resource "aws_iam_user" "admin2" {
  name = "admin2"
}

resource "aws_iam_group_membership" "admin-users" {
  name = "admin-users"

  users = [
    "${aws_iam_user.admin1.name}",
    "${aws_iam_user.admin2.name}",
  ]

  group = "${aws_iam_group.admin.name}"
}
