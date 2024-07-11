resource "azurerm_app_configuration" "shared-app-config" {
  name                = "${var.subscription_group_name}-shared-app-config"
  resource_group_name = azurerm_resource_group.shared-resource-group.name
  location            = azurerm_resource_group.shared-resource-group.location
  sku                 = "free"
}

data "azurerm_client_config" "current" {}

resource "azurerm_role_assignment" "appconf_dataowner" {
  scope                = azurerm_app_configuration.shared-app-config.id
  role_definition_name = "App Configuration Data Owner"
  principal_id         = data.azurerm_client_config.current.object_id
}