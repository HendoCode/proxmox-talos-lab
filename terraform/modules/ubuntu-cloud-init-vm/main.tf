# terraform/modules/ubuntu-cloud-init-vm/main.tf
terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc07"
    }
  }
}

resource "proxmox_vm_qemu" "management_vm" {
  name        = var.vm_name
  target_node = var.target_node
  clone       = var.template_name
  full_clone  = true
  tags        = "talos,exam"

  # VM Resources
  memory             = var.memory
  scsihw             = "virtio-scsi-pci"
  agent              = 1
  start_at_node_boot = true
  boot               = "order=scsi0"
  # bootdisk = "scsi0"

  cpu {
    type    = "host"
    cores   = var.cores
    sockets = var.sockets
  }

  # Cloud-init drive
  disk {
    slot    = "ide2"
    type    = "cloudinit"
    storage = "local-lvm"
  }

  # Storage Configuration
  disk {
    slot    = "scsi0"
    type    = "disk"
    storage = "local-lvm"
    size    = var.disk_size
    discard = true
  }

  # Network configuration with static IP
  network {
    id     = 0
    model  = "virtio"
    bridge = var.network_bridge
  }

  # Cloud-init configuration
  os_type   = "cloud-init"
  ipconfig0 = "ip=${var.ip_address}/24,gw=${var.gateway_ip}"

  # Reference to our cloud-init snippet
  cicustom = "user=local:snippets/management-vm-cloud-init.yml"

  # Serial console for debugging
  serial {
    id   = 0
    type = "socket"
  }

  vga {
    type = "serial0"
  }
}

