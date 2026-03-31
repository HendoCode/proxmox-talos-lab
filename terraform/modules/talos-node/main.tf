# terraform/modules/talos-node/main.tf
terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc07"
    }
  }
}

resource "proxmox_vm_qemu" "talos_node" {
  name        = var.node_prefix
  target_node = var.target_node
  clone       = var.template_name
  full_clone  = true
  boot        = "order=ide2"
  tags        = "talos,exam"
  # bootdisk    = "ide2" # scsi0"

  # Talos Installation ISO
  disk {
    slot = "ide2"
    type = "cdrom"
    iso  = "local:iso/talos-qemu-metal-amd64_1.12.6.iso"
  }

  # Storage Configuration
  disk {
    slot    = "scsi0"
    type    = "disk"
    storage = "local-lvm"
    size    = "10G"
    discard = true
    format  = "raw"
  }

  # VM Configuration
  os_type            = "cloud-init"
  ciuser             = "talos"
  memory             = var.memory
  scsihw             = "virtio-scsi-pci"
  agent              = 1
  start_at_node_boot = true

  # CPU Configuration
  cpu {
    type    = "host"
    cores   = var.cores
    sockets = var.sockets
  }

  # Network Configuration
  network {
    id     = 0
    model  = "virtio"
    bridge = var.network_bridge
  }

  startup_shutdown {
    order            = -1
    shutdown_timeout = -1
    startup_delay    = -1
  }
}

