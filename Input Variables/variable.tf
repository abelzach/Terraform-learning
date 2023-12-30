variable "instance_type" {
  default = "t2.micro"
}
variable "instance_count" {
  description = "Abel's instanace type"
  type = number
  default = 1
}