# Creando el Security group
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group

resource "azurerm_network_security_group" "azcp2SecGroup" {
    name                = "secgrp-${var.vms[count.index]}" #var.vms : lista de vm definidos en vars.tf
    count               = length(var.vms)
    location            = azurerm_resource_group.aztrg.location
    resource_group_name = azurerm_resource_group.aztrg.name

    security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }

    tags = {
        environment = "cp2"
    }
}

# Vinculamos el security group al interface de red
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association

resource "azurerm_network_interface_security_group_association" "azcp2SecGroupAssociation1" {
    count                     = length(var.vms)
    network_interface_id      = azurerm_network_interface.azcp2Nic[count.index].id
    network_security_group_id = azurerm_network_security_group.azcp2SecGroup[count.index].id
}

