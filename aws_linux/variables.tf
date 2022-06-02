variable "region" {
    description = "aws region"
    type        = string
    default     = "us-east-1"  
}

variable "instance_type" {
    description = "aws instance type"
    type        = string
    default     = "t2.micro"
}

variable "allow_ports" {
    description = "List of allow open ports"
    type        = list
    default     = ["22"]
}

variable "cidr_blocks" {
    description = "List of allow ip's"
    type        = list
    default     = ["195.64.234.134/32","116.203.53.241/32" ]
}

variable "common_tags" {
    description = "Common tags for all resources"
    type        = map
    default     = {
        Owner       = "db"
        Project     = "Temp"
        Environment = "Test"
    }
}