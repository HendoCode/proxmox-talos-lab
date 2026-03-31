# Proxmox Configuration
variable "target_node" {
  type        = string
  description = "Proxmox node name where VMs will be created"
}

variable "ubuntu_template" {
  type        = string
  description = "Name of the Ubuntu cloud-init template"
  default     = "ubuntu-22.04-template"
}

variable "talos_template" {
  type        = string
  description = "Name of the Talos template"
  default     = "talos-template"
}

# Network Configuration
variable "management_ip" {
  type        = string
  description = "Static IP for management VM"
  default     = "192.168.1.200"
}

variable "gateway_ip" {
  type        = string
  description = "Network gateway IP"
  default     = "192.168.1.254"
}

variable "network_bridge" {
  type        = string
  description = "Proxmox network bridge"
  default     = "vmbr0"
}

# Cluster Sizing
variable "controlplane_count" {
  type        = number
  description = "Number of control plane nodes"
  default     = 3
  validation {
    condition     = var.controlplane_count >= 1 && var.controlplane_count % 2 == 1
    error_message = "Control plane count must be an odd number (1, 3, 5, etc.) for proper etcd quorum."
  }
}

variable "worker_count" {
  type        = number
  description = "Number of worker nodes"
  default     = 2
}

# Resource Configuration
variable "management_vm_memory" {
  type        = number
  description = "Memory for management VM in MB"
  default     = 4096
}

variable "management_vm_cores" {
  type        = number
  description = "CPU cores for management VM"
  default     = 2
}

variable "controlplane_memory" {
  type        = number
  description = "Memory for control plane nodes in MB"
  default     = 2048
}

variable "controlplane_cores" {
  type        = number
  description = "CPU cores for control plane nodes"
  default     = 2
}

variable "worker_memory" {
  type        = number
  description = "Memory for worker nodes in MB"
  default     = 4096
}

variable "worker_cores" {
  type        = number
  description = "CPU cores for worker nodes"
  default     = 4
}

# Storage Configuration
variable "disk_storage" {
  type        = string
  description = "Proxmox storage location for VM disks"
  default     = "local-lvm"
}

