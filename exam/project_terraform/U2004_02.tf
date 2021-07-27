# Create VM in vApp

resource "vcd_vapp_vm" "vm2" {
  vapp_name     = vcd_vapp.vms.name
  name          = var.vm_name_vm2
  computer_name = var.vm_name_vm2
  catalog_name  = var.vcd_org_catalog
  template_name = var.template_vm
  memory        = var.vm_ram_size
  cpus          = var.vm_cpu_count
  cpu_cores     = var.vm_cpu_cores_count

  depends_on = [vcd_network_routed.internalRouted, vcd_vapp.vms]

  network {
    type               = "org"
    name               = vcd_network_routed.internalRouted.name
    ip                 = var.vm_lip_vm2
    ip_allocation_mode = "MANUAL"
  }

}

# FW rule for ssh access to VM

resource "vcd_nsxv_firewall_rule" "vm2_SSH" {
  edge_gateway   = var.vcd_org_edge_name

  name           = "SSH access"

  source {
    ip_addresses       = ["any"]
  }

  destination {
    ip_addresses = [var.vm_pip_vm2]
  }

  service {
    protocol = "tcp"
    port     = "22"
  }

}

resource "vcd_nsxv_firewall_rule" "vm2_http" {
  edge_gateway   = var.vcd_org_edge_name

  name           = "http access"

  source {
    ip_addresses       = ["any"]
  }

  destination {
    ip_addresses = [var.vm_pip_vm2]
  }

  service {
    protocol = "tcp"
    port     = "80"
  }

}


# DNAT for VM

resource "vcd_nsxv_dnat" "vm2_SSH" {
  edge_gateway = var.vcd_org_edge_name
  network_name = var.vcd_edge_network_name
  network_type = "ext"

  description = "DNAT rule for ssh"

  original_address   = var.vm_pip_vm2
  original_port      = 22
  translated_address = var.vm_lip_vm2
  translated_port    = 22
  protocol           = "tcp"

  depends_on = [vcd_network_routed.internalRouted]
}

resource "vcd_nsxv_dnat" "vm2_http" {
  edge_gateway = var.vcd_org_edge_name
  network_name = var.vcd_edge_network_name
  network_type = "ext"

  description = "DNAT rule for http"

  original_address   = var.vm_pip_vm2
  original_port      = 80
  translated_address = var.vm_lip_vm2
  translated_port    = 80
  protocol           = "tcp"

  depends_on = [vcd_network_routed.internalRouted]
}

