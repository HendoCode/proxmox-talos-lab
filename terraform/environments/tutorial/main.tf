# Management VM
# module "management_vm" {
#   source = "../../modules/ubuntu-cloud-init-vm"

#   vm_name           = "cluster-mgmt"
#   target_node       = var.target_node
#   template_name     = var.ubuntu_template
#   memory            = var.management_vm_memory
#   cores             = var.management_vm_cores
#   ip_address        = var.management_ip
#   gateway_ip        = var.gateway_ip
#   network_bridge    = var.network_bridge
#   cloud_init_snippet = "management-vm-cloud-init.yml"
#   disk_storage      = var.disk_storage
# }

# Control Plane Nodes
module "control_plane_nodes" {
  count  = var.controlplane_count
  source = "../../modules/talos-node"

  node_prefix    = "tutorial-cp-${count.index + 1}"
  target_node    = var.target_node
  template_name  = var.talos_template
  memory         = var.controlplane_memory
  cores          = var.controlplane_cores
  network_bridge = var.network_bridge
  disk_storage   = var.disk_storage
}

# Worker Nodes
module "worker_nodes" {
  count  = var.worker_count
  source = "../../modules/talos-node"

  node_prefix    = "tutorial-worker-${count.index + 1}"
  target_node    = var.target_node
  template_name  = var.talos_template
  memory         = var.worker_memory
  cores          = var.worker_cores
  network_bridge = var.network_bridge
  disk_storage   = var.disk_storage
}

