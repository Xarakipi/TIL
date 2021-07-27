variable "vcd_org_user" {
  default     = "administrator"
  description = "vCD Tenant User"
}

variable "vcd_org_pass" {
  default     = "password"
  description = "vCD Tenant Password"
}

variable "vcd_org_org" {
  default     = "def_org"
  description = "vCD Tenant Org"
}

variable "vcd_org_url" {
  default     = "https://cloud.stack24.net/api"
  description = "vCD Tenant URL"
}

variable "vcd_org_vdc" {
  default     = "def_org_vdc"
  description = "vCD Tenant VDC"
}

variable "vcd_org_max_retry_timeout" {
  description = "Retry Timeout"
  default     = "240"
}

variable "vcd_org_edge_name" {
  description = "vCD edge name"
  default     = "def_edge"
}

variable "vcd_org_catalog" {
  description = "vCD Catalog Name"
}

variable "template_vm" {
  description = "template vm"
  default = "U2004"
}

variable "name_network_routed" {
  description = "Routed network name"
  default = "Local_orgname_01"
}

variable "gw_network_routed" {
  description = "Routed network gateway"
  default = "192.168.0.1"
}

variable "dns1_network_routed" {
  description = "Routed network Primary DNS"
  default = "1.1.1.1"
}

variable "dns2_network_routed" {
  description = "Routed network Secondary DNS"
  default = "8.8.8.8"
}

variable "dhcp_start_routnet" {
  description = "Routed network DHCP pool start IP"
  default = "192.168.0.2"
}

variable "dhcp_end_routnet" {
  description = "Routed network DHCP pool end IP"
  default = "192.168.0.100"
}

variable "static_start_routnet" {
  description = "Routed network static pool start IP"
  default = "192.168.0.2"
}

variable "static_end_routnet" {
  description = "Routed network static pool end IP"
  default = "192.168.0.100"
}

variable "vdc_vapp_name" {
  description = "vApp name"
  default = "vApp_01"
}

variable "ipmask_network_routed" {
  description = "Routed network CIDR"
  default = "192.168.0.0/24"
}

variable "vcd_edge_network_name" {
  description = "Edge gw external network interface"
  default = "def_ext_interface"
}

variable "vcd_edge_snat_pip" {
  description = "Edge Public IP for SNAT"
  default = "10.10.10.10"
}

variable "vm_ram_size" {
  description = "VM Memory size"
  default = "1024"
}

variable "vm_cpu_count" {
  description = "VM CPU count"
  default = "1"
}

variable "vm_cpu_cores_count" {
  description = "VM CPU Cores count"
  default = "1"
}

variable "vm_name_vm1" {
  description = "VM and Computer name"
  default = "vm-01"
}

variable "vm_lip_vm1" {
  description = "VM Local IP address"
  default = "192.168.0.11"
}

variable "vm_pip_vm1" {
  description = "VM Public IP address"
  default = "10.10.10.11"
}

variable "vm_name_vm2" {
  description = "VM and Computer name"
  default = "vm-02"
}

variable "vm_lip_vm2" {
  description = "VM Local IP address"
  default = "192.168.0.12"
}

variable "vm_pip_vm2" {
  description = "VM Public IP address"
  default = "10.10.10.12"
}

