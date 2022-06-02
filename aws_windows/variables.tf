variable "region" {
    description = "aws region"
    type        = string
    default     = "us-east-1"  
}

variable "instance_type" {
    description = "aws instance type"
    type        = string
    default     = "t2.medium"
}

variable "allow_ports" {
    description = "List of allow open ports"
    type        = list
    default     = ["3389"] // One or several ports
}

variable "cidr_blocks" {
    description = "List of allow ip's"
    type        = list
    default     = ["0.0.0.0/0" ] // One or several ip's
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