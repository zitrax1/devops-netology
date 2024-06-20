### image vars

variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "ubuntu-2004-lts"
}

variable "secure_id" {
  type        = string
  default     = "enp1ci28nk6310bigcce"
  description = "security group"
 }

variable "disk_size" {
  type        = number
  default     = 1
  description = "disk_size"
 }

variable vms_resources {
    description = "vms_resources"
    type = map (object({
    cores = number,
    memory = number,
    core_fraction = number 
}))
    default = {
    "web"= {
    cores=2
    memory=2
    core_fraction=5
   },
    "db"= {
    cores=2
    memory=2
    core_fraction=20
   }
     }
}


### compute vars VM-1

# variable "vm_web_compute_name" {
#   type        = string
#   default     = "netology-develop-platform-web"
#   description = "yandex_compute_instance name"

# }

variable "vm_web_compute_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "yandex_compute_instance platform_id"

}

# variable "vm_web_compute_resources_memory" {
#   type        = number
#   default     = "2"
#   description = "yandex_compute_instance memory"

# }

# variable "vm_web_compute_resources_core_fraction" {
#   type        = number
#   default     = "5"
#   description = "yandex_compute_instance cores_fraction"

# }

### compute vars VM-2

# variable "vm_db_compute_name" {
#   type        = string
#   default     = "netology-develop-platform-db"
#   description = "yandex_compute_instance name"

# }

variable "vm_db_compute_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "yandex_compute_instance platform_id"

}

# variable "vm_db_compute_resources_cores" {
#   type        = number
#   default     = "2"
#   description = "yandex_compute_instance cores"

# }

# variable "vm_db_compute_resources_memory" {
#   type        = number
#   default     = "2"
#   description = "yandex_compute_instance memory"

# }

# variable "vm_db_compute_resources_core_fraction" {
#   type        = number
#   default     = "20"
#   description = "yandex_compute_instance cores_fraction"

# }