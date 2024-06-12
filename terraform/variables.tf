###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
   description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_zone-db" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "default_cidr-db" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name-db" {
  type        = string
  default     = "develop-db"
  description = "VPC network & subnet name"
}


###ssh vars

# variable "vms_ssh_root_key" {
#   type        = string
#   default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHA8PHbIHUYTPxBSM1Z8PYxvzFZ8Zd2wvfeHxwxXMCkh siz@test"
#   description = "ssh-keygen -t ed25519"
# }

variable "meta" {
   description         = "meta-data"
    type               = map (object({
    ssh-keys = string,
    serial-port-enable = number,
}))

    default = {
      mtd = {
        ssh-keys = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHA8PHbIHUYTPxBSM1Z8PYxvzFZ8Zd2wvfeHxwxXMCkh siz@test",
        serial-port-enable = 1,
      }
    }
}


