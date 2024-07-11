terraform {
  backend "azurerm" {
    # subscription_id      = "f3c8f50d-5de4-4e11-81b3-f446f1ca075a" # sub hub subId
    resource_group_name  = "rg-terraform-backend"
    storage_account_name = "hubsaterraformbackend"
    container_name       = "hubterraformbackend"
    key                  = "sub-group-1-tfstate"
  }
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret

}

resource "azurerm_resource_group" "shared-resource-group" {
  name     = "${var.subscription_group_name}-shared-rg"
  location = "norwayeast"
}

module "shared" {
  source            = "./modules/shared"
  subscription_name = var.subscription_group_name
}

module "app1" {
  source                  = "git::https://github.com/goverland/terraform-base.git//modules/app1"
  customer_names          = var.customer_names
  shared_app_config_id    = module.shared.shared_app_config_id
  subscription_group_name = var.subscription_group_name
  providers = {
    azurerm = azurerm
  }
  # or specify a branch, tag, or commit
  # source = "git::https://github.com/your-org/base-module-repo.git//modules/app1?ref=main"
}

module "app2" {
  source            = "git::https://github.com/goverland/terraform-base.git//modules/app2"
  customer_names    = var.customer_names
  subscription_group_name = var.subscription_group_name
  providers = {
    azurerm = azurerm
  }
  # app_specific_variable = "value"
}
