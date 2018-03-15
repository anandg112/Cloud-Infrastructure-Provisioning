resource "aws_s3_bucket" "b" {
  bucket = "mybucket-anand-gautam"
  acl = "private"
  
  tags {
    Name = "mybucket-anand-gautam"
  }
}