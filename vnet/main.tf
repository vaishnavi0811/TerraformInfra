variable "location"{
  type = string
}
variable "rgName"{
  type = string
}
variable "client_id" {
  type = string
}
variable "client_secret" {
  type = string
}
variable "subscription_id" {
  type = string
}
variable "tenant_id" {
  type = string
}
provider "azurerm" {
	 client_id = var.client_id
	 client_secret = var.client_secret
	 subscription_id = var.subscription_id
	 tenant_id = var.tenant_id
	 features {}
}
resource "azurerm_virtual_network" "example" {
  name                = "virtualNetwork1"
  location            = var.location
  resource_group_name = var.rgName
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.example.id
    enable = true
  }

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
  }

  subnet {
    name           = "subnet3"
    address_prefix = "10.0.3.0/24"
    security_group = azurerm_network_security_group.example.id
  }

  tags = {
    environment = "Production"
  }
}