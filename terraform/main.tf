resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_vpc_network" "develop-db" {
  name = var.vpc_name-db
}
resource "yandex_vpc_subnet" "develop-db" {
  name           = var.vpc_name-db
  zone           = var.default_zone-db
  network_id     = yandex_vpc_network.develop-db.id
  v4_cidr_blocks = var.default_cidr-db
}

data "yandex_compute_image" "ubuntu" {
  family = "${var.vm_web_image}"
}
resource "yandex_compute_instance" "platform" {
  name        = "${local.VM1}" #"${var.vm_web_compute_name}"
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
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.meta.mtd.serial-port-enable
    ssh-keys           = "ubuntu:${var.meta.mtd.ssh-keys}"
  }

}

resource "yandex_compute_instance" "platform-db" {
  name        = "${local.VM2}" #"${var.vm_db_compute_name}"
  platform_id = "${var.vm_db_compute_platform_id}"
  zone        = var.default_zone-db
  resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
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
    subnet_id = yandex_vpc_subnet.develop-db.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.meta.mtd.serial-port-enable
    ssh-keys           = "ubuntu:${var.meta.mtd.ssh-keys}"
  }

}