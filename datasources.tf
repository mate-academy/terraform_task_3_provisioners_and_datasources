# Отримання даних про ІСНУЮЧУ групу ресурсів
data "azurerm_resource_group" "main" {
  name = var.resource_group_name
}

# Отримання даних про ІСНУЮЧУ віртуальну мережу
data "azurerm_virtual_network" "main" {
  name                = var.virtual_network_name
  resource_group_name = data.azurerm_resource_group.main.name
}

# Отримання даних про ІСНУЮЧУ підмережу
data "azurerm_subnet" "main" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.main.name
  resource_group_name  = data.azurerm_resource_group.main.name
}

# Отримання даних про ІСНУЮЧИЙ мережевий інтерфейс
data "azurerm_network_interface" "main" {
  name                = var.network_interface_name
  resource_group_name = data.azurerm_resource_group.main.name
}

# Отримання даних про ІСНУЮЧУ віртуальну машину
data "azurerm_virtual_machine" "main" {
  name                = var.virtual_machine_name
  resource_group_name = data.azurerm_resource_group.main.name
}

# Отримання даних про публічну IP-адресу
data "azurerm_public_ip" "main" {
  name                = reverse(split("/", data.azurerm_network_interface.main.ip_configuration[0].public_ip_address_id))[0]
  resource_group_name = data.azurerm_resource_group.main.name
}