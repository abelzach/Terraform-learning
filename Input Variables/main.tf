provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "Test" {
  ami = "ami-0c7217cdde317cfec"
  instance_type = var.instance_type
  count = var.instance_count
  tags = {
    Name = "Abel_Test"
  }
}
# resource "aws_lightsail_instance" "test" {
#   name              = "Abel_Test"
#   availability_zone = "us-east-1b"
#   blueprint_id      = var.blueprint_id
#   bundle_id         = "nano_1_0"
#   tags = {
#     foo = "bar"
#   }
# }
