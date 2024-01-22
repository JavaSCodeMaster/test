output "storage_connection_string" {
  value = azurerm_storage_account.img-stor.primary_connection_string
}
