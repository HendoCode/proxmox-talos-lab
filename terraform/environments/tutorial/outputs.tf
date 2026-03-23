# Management VM Outputs
# output "management_vm" {
#   description = "Management VM information"
#   value = {
#     name       = module.management_vm.vm_name
#     ip_address = module.management_vm.vm_ipv4_address
#     ssh_command = module.management_vm.ssh_connection
#   }
# }

# Control Plane Outputs
output "control_plane_nodes" {
  description = "Control plane node information"
  value = {
    for i, node in module.control_plane_nodes : node.vm_name => {
      vm_id     = node.vm_id
      dhcp_ip   = node.vm_ipv4_address
      node_type = "controlplane"
    }
  }
}

# Worker Node Outputs
output "worker_nodes" {
  description = "Worker node information"
  value = {
    for i, node in module.worker_nodes : node.vm_name => {
      vm_id     = node.vm_id
      dhcp_ip   = node.vm_ipv4_address
      node_type = "worker"
    }
  }
}

# Combined cluster output for easy reference
output "talos_cluster_nodes" {
  description = "All Talos cluster nodes"
  value = merge(
    {
      for i, node in module.control_plane_nodes : node.vm_name => {
        vm_id     = node.vm_id
        dhcp_ip   = node.vm_ipv4_address
        node_type = "controlplane"
      }
    },
    {
      for i, node in module.worker_nodes : node.vm_name => {
        vm_id     = node.vm_id
        dhcp_ip   = node.vm_ipv4_address
        node_type = "worker"
      }
    }
  )
}

