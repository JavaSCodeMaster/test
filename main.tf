locals {
  resource_suffix = "${var.env_suffix}-${var.region_suffix}-${var.instance_suffix}"
}

module "resource-group" {
  source              = "./modules/resource-group"
  resource_group_name = "rg-managed-platform-${local.resource_suffix}"
  region              = var.region
}

module "storage-account" {
  source                   = "./modules/storage-account"
  storage_account_name     = "stimgstor${var.env_suffix}${var.region_suffix}${var.instance_suffix}"
  account_replication_type = var.account_replication_type
  account_tier             = var.account_tier
  region_suffix            = var.region_suffix
  resource_group_location  = module.resource-group.resource_group_location
  resource_group_name      = module.resource-group.resource_group_name
  depends_on = [
    module.resource-group
  ]
}

module "app-service-plan-backend" {
  source                  = "./modules/app-service-plan"
  app_service_plan_name   = "aps-back-${local.resource_suffix}"
  resource_group_location = module.resource-group.resource_group_location
  resource_group_name     = module.resource-group.resource_group_name
  os_type                 = var.os_type
  sku_name                = var.sku_name
  depends_on = [
    module.resource-group
  ]
}

module "web-app-backend" {
  source                    = "./modules/web-app-backend"
  web_app_name              = "web-app-back-${local.resource_suffix}"
  resource_group_location   = module.resource-group.resource_group_location
  resource_group_name       = module.resource-group.resource_group_name
  service_plan_id           = module.app-service-plan-backend.service_plan_id
  storage_connection_string = module.storage-account.storage_connection_string
  depends_on = [
    module.app-service-plan-backend
  ]
}

module "app-service-plan-front" {
  source                  = "./modules/app-service-plan"
  app_service_plan_name   = "aps-front-${local.resource_suffix}"
  resource_group_location = module.resource-group.resource_group_location
  resource_group_name     = module.resource-group.resource_group_name
  os_type                 = var.os_type
  sku_name                = var.sku_name
  depends_on = [
    module.resource-group
  ]
}

module "web-app-front" {
  source                  = "./modules/web-app-front"
  web_app_name            = "web-app-front-${local.resource_suffix}"
  resource_group_location = module.resource-group.resource_group_location
  resource_group_name     = module.resource-group.resource_group_name
  service_plan_id         = module.app-service-plan-front.service_plan_id
  web_app_default_host    = module.web-app-backend.web_app_default_host
  depends_on = [
    module.app-service-plan-front
  ]
}

