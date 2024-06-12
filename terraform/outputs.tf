output "servers" {

  value = [
    { platform = [yandex_compute_instance.platform.name , yandex_compute_instance.platform.network_interface[0].nat_ip_address , yandex_compute_instance.platform.fqdn] },
    { platform-db = [yandex_compute_instance.platform-db.name , yandex_compute_instance.platform.network_interface[0].nat_ip_address , yandex_compute_instance.platform-db.fqdn] }
  ]
}