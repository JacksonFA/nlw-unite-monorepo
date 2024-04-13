module "oci-oke" {
  source                        = "github.com/oracle-devrel/terraform-oci-arch-oke"
  tenancy_ocid                  = var.tenancy_ocid
  compartment_ocid              = var.compartment_ocid
  oke_cluster_name              = var.oke_cluster_name
  k8s_version                   = var.k8s_version
  pool_name                     = var.pool_name
  node_shape                    = var.node_shape
  node_ocpus                    = var.node_ocpus
  node_memory                   = var.node_memory
  node_count                    = var.node_count
  use_existing_vcn              = false
  is_api_endpoint_subnet_public = true # OKE API Endpoint will be public (Internet facing)
  is_lb_subnet_public           = true # OKE LoadBalanacer will be public (Internet facing)
  is_nodepool_subnet_public     = true # OKE NodePool will be public (Internet facing)
}
