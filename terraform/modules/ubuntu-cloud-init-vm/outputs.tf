output "vm_id" {
  description = "ID of the created VM"
  value       = proxmox_vm_qemu.management_vm.vmid
}

output "vm_name" {
  description = "Name of the created VM"
  value       = proxmox_vm_qemu.management_vm.name
}

output "vm_ipv4_address" {
  description = "IPv4 address of the VM"
  value       = var.ip_address
}

output "ssh_connection" {
  description = "SSH connection command"
  value       = "ssh ${var.vm_name}@${var.ip_address}"
}
