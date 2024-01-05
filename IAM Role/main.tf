provider "aws" {
  region = "us-east-1"
}

# Creating IAM role
resource "aws_iam_role" "test_role" {
  name = "test_abel"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

# IAM role policy attachment 
resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.test_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# IAM Instance profile
resource "aws_iam_instance_profile" "test_profile" {
  name = "abel_instance_profile"
  role = aws_iam_role.test_role.name
}

# EC2 instance
resource "aws_instance" "test_instance" {
  ami = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  subnet_id = "subnet-00803e497ba34bd3e"

  iam_instance_profile = aws_iam_instance_profile.test_profile.name

  tags = {
    Name = "Abel_EC2"
  }
}