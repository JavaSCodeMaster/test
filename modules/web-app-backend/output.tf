output "web_app_default_host" {
  value = "https://${azurerm_windows_web_app.web-app.default_hostname}"
}
output "web_app_id" {
  value = azurerm_windows_web_app.web-app.id
}

