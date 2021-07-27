# Configure the VMware Cloud Director Provider
provider "vcd" {
  user                 = var.vcd_org_user
  password             = var.vcd_org_pass
  org                  = var.vcd_org_org
  vdc                  = var.vcd_org_vdc
  url                  = var.vcd_org_url
}

# Create routed network
resource "vcd_network_routed" "internalRouted" {
  name         = var.name_network_routed
# Указывается имя edge шлюза
  edge_gateway = var.vcd_org_edge_name

  gateway = var.gw_network_routed
  dns1 = var.dns1_network_routed
  dns2 = var.dns2_network_routed

  dhcp_pool {
    start_address = var.dhcp_start_routnet
    end_address   = var.dhcp_end_routnet
  }

  static_ip_pool {
    start_address = var.static_start_routnet
    end_address   = var.static_end_routnet
  }
}

# Create vApp

resource "vcd_vapp" "vms" {
  name = var.vdc_vapp_name
  power_on = "true"

  depends_on = [vcd_network_routed.internalRouted]
}

resource "vcd_vapp_org_network" "routed-network" {
  vapp_name         = vcd_vapp.vms.name
  org_network_name  = vcd_network_routed.internalRouted.name

  depends_on = [vcd_network_routed.internalRouted]
}

# Access to internet

resource "vcd_nsxv_firewall_rule" "Internet" {
  edge_gateway   = var.vcd_org_edge_name

  name           = "access to inet"

  source {
    ip_addresses = [var.ipmask_network_routed]

  }

  destination {
    ip_addresses       = ["any"]

  }

  service {
    protocol = "any"
  }

}

# SNAT

resource "vcd_nsxv_snat" "outbound" {

  edge_gateway = var.vcd_org_edge_name
  network_type = "ext"
  network_name = var.vcd_edge_network_name

  description = "SNAT rule"

  original_address   = var.ipmask_network_routed
  translated_address = var.vcd_edge_snat_pip

  depends_on = [vcd_network_routed.internalRouted]
}
