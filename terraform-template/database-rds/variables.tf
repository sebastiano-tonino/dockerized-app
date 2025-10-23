// Variables definition file
variable "backend_state" {
  type    = string
  default = ""
}

variable "backend" {
  type    = string
  default = ""
}

variable "account" {
  type    = string
  default = "dev"
}

variable "common_tags" {
  type = map(string)
  default = {
    Client     = ""
    Project    = ""
    Stage      = "dev"
    DevOpsTool = "tofu"
  }
}
