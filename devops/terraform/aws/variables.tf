
variable "azs" {
  default = ["us-east-2a", "us-east-2b", "us-east-2c"]
}

variable "private_subnet" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "public_subnet" {
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}