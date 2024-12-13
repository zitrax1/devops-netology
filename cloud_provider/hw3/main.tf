### VPC
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

### SA ACCAUNT

resource "yandex_iam_service_account" "sa" {
  name = var.sa_name
}

// Назначение роли сервисному аккаунту
resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
  folder_id = var.folder_id
  role      = "storage.admin"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}

// Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}

// создание GI user
resource "yandex_iam_service_account" "gi" {
  name = var.gi_name
}

// Назначение роли сервисному аккаунту group instance
resource "yandex_resourcemanager_folder_iam_member" "gi-admin" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.gi.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "gi-vpc-admin" {
  folder_id = var.folder_id
  role      = "vpc.admin"
  member    = "serviceAccount:${yandex_iam_service_account.gi.id}"
}


### KMS
resource "yandex_kms_symmetric_key" "kms_key" {
  name       = "kms-key"
  description = "Key for bucket encryption"
  rotation_interval = "8760h" # 1 year
  status     = "ACTIVE"
}


### BUCKET

// Создание бакета с использованием ключа
resource "yandex_storage_bucket" "siz-bucket" {
  access_key            = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key            = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket                = var.bucket_name
  max_size              = 1048576000
  default_storage_class = "standard"
  anonymous_access_flags {
    read        = true
    list        = true
    config_read = false
  }
  encryption {
    default_kms_key_id = yandex_kms_symmetric_key.kms_key.id
  }
}
resource "yandex_storage_object" "image" {
  access_key            = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key            = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket                = yandex_storage_bucket.siz-bucket.bucket
  key                   = "destoy.jpg"
  source                = "/home/siz/destoy.jpg"
  acl                   = "public-read"
}

### INSTANCES

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
    subnet_id = yandex_vpc_subnet.private.id
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

resource "yandex_compute_instance_group" "lamp-group" {
  name        = "lamp-group-01"
  service_account_id = yandex_iam_service_account.gi.id
  folder_id   = var.folder_id

  instance_template {
    platform_id = "${var.vm_nat_compute_platform_id}"
    resources {
      cores         = var.vms_resources.nat.cores
      memory        = var.vms_resources.nat.memory
    }
    boot_disk {
      initialize_params {
        image_id = var.LAMP_img
      }
    }
    scheduling_policy {
    preemptible = true
  }
    network_interface {
      subnet_ids = [yandex_vpc_subnet.public.id]
      nat        = true
    }
    metadata = {
      ssh-keys           = "ubuntu:${var.meta.mtd.ssh-keys}"
      user-data = <<-EOT
        #cloud-config
        runcmd:
          - echo '<html><body><h1>Welcome to LAMP!</h1><img src="http://$${yandex_storage_bucket.siz-bucket.bucket}.storage.yandexcloud.net/$${yandex_storage_object.image.key}" alt="Bucket Image"></body></html>' > /var/www/html/index.html
      EOT
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }
    allocation_policy {
    zones = [var.default_zone]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 1
  }

  health_check {
    http_options {
      port = 80
      path = "/"
    }
    interval            = 10
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 3
  }

  load_balancer {
    target_group_name        = "tg-balance"
    target_group_description = "Целевая группа Network Load Balancer"
  }
}

## Load Balancer
resource "yandex_lb_network_load_balancer" "lb" {
  name = "lamp-load-balancer"

  listener {
    name = "http"
    port = 80
    target_port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_compute_instance_group.lamp-group.load_balancer.0.target_group_id

    healthcheck {
      name = "http"
      http_options {
        port = 80
      }
    }
  }
}

### ROUTETABLE

resource "yandex_vpc_route_table" "private_route_table" {
  name      = "private-route-table"
  network_id = yandex_vpc_network.public.id

  static_route {
    destination_prefix = var.private_net.private.dst_pref
    next_hop_address   = var.private_net.private.nxt_hop
  }
}

