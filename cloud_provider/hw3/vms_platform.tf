### image vars

variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "ubuntu-2004-lts"

}

variable "nat_img" { 
  type = string
  default = "fd80mrhj8fl2oe87o4e1"
  description = "some img"
  
  }

  variable "LAMP_img" { 
  type = string
  default = "fd827b91d99psvq5fjit"
  description = "some img"
  
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
    "nat"= {
    cores=2
    memory=2
    core_fraction=20
   }
     }
}
variable vms_ip {
  description = "vms_ip"
  type = string
  default = "192.168.10.254"  
}

variable private_net { 
  description = "private_rt"
    type = map (object({
    dst_pref = string,
    nxt_hop = string,
}))
    default = {
    "private"= {
    dst_pref = "0.0.0.0/0"
    nxt_hop   = "192.168.10.254"
   }
}
}

variable "vm_web_compute_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "yandex_compute_instance platform_id"

}


variable "vm_nat_compute_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "yandex_compute_instance platform_id"

}

variable "vm_lamp_compute_platform_id" {
  type        = string
  default     = "standard-v1"
  description = "yandex_compute_instance platform_id"

}