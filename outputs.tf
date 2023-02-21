output "bot" {
  value = data.google_container_registry_image.some-bot.image_url
}

output "success" {
  value = "ready to ping"
}
