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


### VPC

variable "vpc_name" {
  type        = string
  default     = "public"
  description = "VPC network & subnet name"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_private" {
  type        = string
  default     = "private"
  description = "VPC network & subnet name"
}

variable "private_cidr" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

###META

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


### BUCKET
variable "bucket_name" {
  description = "bucket name"
  type = string
  default = "tfhw2"
}

variable "sa_name"{
description = "Service accaunt for bucket"
type = string
default = "sa-admin"
}

# variable "bucket_image_url" {
#   description = "URL of the image in Object Storage bucket"
#   default     = "http://${yandex_storage_bucket.test.bucket}.storage.yandexcloud.net/${yandex_storage_object.image.key}"
# }

### istance group

variable "gi_name"{
description = "Service accaunt for group instance"
type = string
default = "gi-admin"
}