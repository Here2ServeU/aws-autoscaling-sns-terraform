variable "AWS_REGION" {
  default = "us-east-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "key"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "key.pub"
}

variable "AMIS" {
  type = map(string)
  default = {   # Replace with the Desired AMIs. 
    us-east-1 = "ami-0e001c9271cf7f3b9"
    us-west-1 = "ami-0e001c9271cf7f3b9"
    us-east-2 = "ami-0e001c9271cf7f3b9"
  }
}

variable "email" {
  default = "student4t2s@gmail.com"
}
