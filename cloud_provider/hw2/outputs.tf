output "public_image_url" {
  value = "https://${yandex_storage_bucket.siz-bucket.bucket}.storage.yandexcloud.net/${yandex_storage_object.image.key}"
}
