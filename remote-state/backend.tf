terraform {
   backend "s3" {
     bucket = "terraform-remote-anand"
     key = "terraform/remote-demo"
     region = "us-east-1"
   }
}
