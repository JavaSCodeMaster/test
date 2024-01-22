resource "azurerm_windows_web_app" "web-app" {
  name                = var.web_app_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  service_plan_id     = var.service_plan_id

  app_settings = {
    ApiUrl = var.web_app_default_host
  }

  site_config {
    application_stack {
      current_stack = "dotnet"
      dotnet_version = "v6.0"
    }
  }
}
