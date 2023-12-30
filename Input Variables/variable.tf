variable "instance_type" {
  default = "t2.micro"
}
variable "blueprint_id" {
  default = "amazon_linux_2"
}
variable "instance_count" {
  description = "Abel's instanace type"
  type = number
  default = 1
}