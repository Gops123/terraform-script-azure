
provider "azure" {
  publish_settings = "${file("credentials.json")}"
}

resource "azure_security_group" "web" {
  name     = "webservers"
  location = "${var.location}"
}

resource "azurerm_resource_group" "test" {
  name     = "production"
  location = "${var.location}"
}

resource "azure_virtual_network" "test" {
  name          = "test-network"
  address_space = ["${var.address_space}"]
  location      = "${var.location}"

  subnet {
    name           = "subnet1"
    address_prefix = "${var.address_prefix}"
  }
}

resource "azure_security_group_rule" "ssh_access" {
  name                       = "ssh-access-rule"
  security_group_names       = ["${azure_security_group.web.name}"]
  type                       = "${var.type}"
  action                     = "Allow"
  priority                   = 200
  source_address_prefix      = "${var.source_address_prefix}"
  source_port_range          = "${var.source_port_range}"
  destination_address_prefix = "${var.destination_address_prefix}"
  destination_port_range     = "${var.destination_port_range}"
  protocol                   = "TCP"
}
