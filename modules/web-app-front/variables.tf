variable "resource_group_name" {
  type = string
}
variable "resource_group_location" {
  type = string
}
variable "service_plan_id" {
  type = string
}
variable "web_app_name" {
  type = string
}
variable "web_app_default_host" {
  type = string
  nullable = true
}

