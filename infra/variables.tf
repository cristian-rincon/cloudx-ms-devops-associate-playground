variable "prefix" {
  type        = string
  description = "A prefix for all resources in this example"
  default     = "cloudx"
}

variable "environment" {
  type        = string
  description = "The environment for all resources in this example"
  default     = "dev"
}

variable "identifier" {
  type        = string
  description = "A unique identifier for all resources in this example"
  default     = "820548440a04bd6e"
}

variable "short_identifier" {
  type        = string
  description = "A unique identifier for all resources in this example"
  default     = "0a04bd6e"
}

variable "db_username" {
  type        = string
  description = "The username for the database"
}

variable "db_password" {
  type        = string
  description = "The password for the database"
}

variable "db_host" {
  type        = string
  description = "The hostname for the database"
}

variable "db_name" {
  type        = string
  description = "The name of the database"
}