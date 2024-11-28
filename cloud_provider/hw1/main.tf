resource "yandex_vpc_network" "public" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "public" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.public.id
  v4_cidr_blocks = var.default_cidr
}
resource "yandex_vpc_subnet" "private" {
  name           = var.vpc_private
  zone           = var.default_zone
  network_id     = yandex_vpc_network.public.id
  v4_cidr_blocks = var.private_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = "${var.vm_web_image}"
}
resource "yandex_compute_instance" "platform" {
  name        = "${local.VM1}" 
  platform_id = "${var.vm_web_compute_platform_id}"
  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.meta.mtd.serial-port-enable
    ssh-keys           = "ubuntu:${var.meta.mtd.ssh-keys}"
  }

}

resource "yandex_compute_instance" "NAT" {
  name        = "${local.VM2}" 
  platform_id = "${var.vm_nat_compute_platform_id}"
  resources {
    cores         = var.vms_resources.nat.cores
    memory        = var.vms_resources.nat.memory
    core_fraction = var.vms_resources.nat.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = var.nat_img
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
    ip_address = var.vms_ip
  }

  metadata = {
    serial-port-enable = var.meta.mtd.serial-port-enable
    ssh-keys           = "ubuntu:${var.meta.mtd.ssh-keys}"
  }
}
resource "yandex_compute_instance" "private" {
  name        = "${local.VM3}" 
  platform_id = "${var.vm_nat_compute_platform_id}"
  resources {
    cores         = var.vms_resources.nat.cores
    memory        = var.vms_resources.nat.memory
    core_fraction = var.vms_resources.nat.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
    nat       = false
  }

  metadata = {
    serial-port-enable = var.meta.mtd.serial-port-enable
    ssh-keys           = "ubuntu:${var.meta.mtd.ssh-keys}"
  }
}


resource "yandex_vpc_route_table" "private_route_table" {
  name      = "private-route-table"
  network_id = yandex_vpc_network.public.id

  static_route {
    destination_prefix = var.private_net.private.dst_pref
    next_hop_address   = var.private_net.private.nxt_hop
  }
}

