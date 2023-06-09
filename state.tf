terraform {
  backend "s3" {
    bucket = "terrafrom-syam"
    key    = "roboshop/dev/terrafrom.tfstate"
    region = "us-east-1"
  }
}
