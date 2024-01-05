provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "Vault_test_instance" {
  ami = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  tags = {
    Name = "Vault_Ubuntu_Test"
    Secret = data.vault_kv_secret_v2.example.data["foo"]
  }
}

provider "vault" {
  address = "<>:8200"
  skip_child_token = true

  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id = "<role id>"
      secret_id = "<secret id>"
    }
  }
}

data "vault_kv_secret_v2" "example" {
  name = "test-secret"
  mount = "secret"
}
