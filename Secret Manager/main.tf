provider "aws" {
  region = "us-east-1"
}

# KMS key
resource "aws_kms_key" "abel-key" {
  description             = "KMS key for test purposes"
  deletion_window_in_days = 7
  enable_key_rotation = true
}

# secret manager
resource "aws_secretsmanager_secret" "demo_cred" {
  name = "demo_purposes"
  kms_key_id = aws_kms_key.abel-key.key_id
}

# secret version
resource "aws_secretsmanager_secret_version" "demo_version" {
  secret_id     = aws_secretsmanager_secret.demo_cred.id
  secret_string = jsonencode ({
    username= "abel",
    password= "simon"
  })
}