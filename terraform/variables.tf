variable "my_ip" {
  description = "My IP address for SSH access"
  type        = string
  default     = 10.0.0.17 # Put your_ip or overwrite it using: terraform apply -var "my_ip=your_ip"
}

