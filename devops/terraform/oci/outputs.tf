output "KubeConfig" {
  value = module.oci-oke.KubeConfig
}

output "Cluster" {
  value = module.oci-oke.cluster
}

output "NodePool" {
  value = module.oci-oke.node_pool
}
