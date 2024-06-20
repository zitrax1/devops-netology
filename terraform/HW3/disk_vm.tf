resource "yandex_compute_disk" "storage_1" {
  count   = 3
  name  = "disk-${count.index + 1}"
  size  = var.disk_size
}


resource "yandex_compute_instance" "storage" {
  name = "storage"
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

  dynamic "secondary_disk" {
   for_each = { for stor in yandex_compute_disk.storage_1[*]: stor.name=> stor }
   content {
     disk_id = secondary_disk.value.id
   }
  }
  network_interface {
     subnet_id = yandex_vpc_subnet.develop.id
     nat     = true
  }

  metadata = local.vms_metadata
}
