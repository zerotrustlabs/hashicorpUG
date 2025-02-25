terraform {
  required_version = "~> 1.0"
  required_providers {
    azurerm = {
      version = "~> 3.18"
    }
  }
}
provider "azurerm" {
  features {}
}
resource "azurerm_resource_group" "rg-app" {
  name     = "RG_MyAPP_demo"
  location = "West Europe"
}
module "webapp" {
  source = "../Modules/webapp"
  service_plan_name = "spmyapp"
  app_name = "myappdemo"
  location = azurerm_resource_group.rg-app.location
  resource_group_name = azurerm_resource_group.rg-app.name
}
output "webapp_url" {
  value = module.webapp.webapp_url
}
