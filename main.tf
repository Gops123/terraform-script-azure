
provider "azure" {
  publish_settings = "${file("credentials.publishsettings")}"
}

resource "azure_security_group" "web" {
  name     = "webservers"
  location = "${var.location}"
}

resource "azure_virtual_network" "default" {
  name          = "test-network"
  address_space = ["10.1.2.0/24"]
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
