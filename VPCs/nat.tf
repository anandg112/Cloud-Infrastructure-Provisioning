#nat gw
resource "aws_eip" "nat" {
 vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id = "${aws_subnet.main-public-1.id}"
  depends_on = ["aws_internet_gateway.main-gw"]
}

#vpc setup for NAT
resource "aws_route_table" "main-private" {
  vpc_id = "${aws_vpc.main.id}"
  route {
  cidr_block = "0.0.0.0/0"
  nat_gateway_id = "${aws_nat_gateway.nat-gw.id}"
 }

 tags {
  Name = "main-private-1"
 }
}

