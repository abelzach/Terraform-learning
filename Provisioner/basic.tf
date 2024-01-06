# provider "aws" {
#   region = "us-east-1"
# }

# # EC2 instance
# resource "aws_instance" "test_instance" {
#   ami = "ami-0c7217cdde317cfec"
#   instance_type = "t2.micro"
#   subnet_id = "subnet-00803e497ba34bd3e"
#   provisioner "local-exec" {
#     command = "echo ${aws_instance.test_instance.private_ip} >> private_ips.txt"
#   }
#   tags = {
#     Name = "Abel_EC2"
#   }
# }