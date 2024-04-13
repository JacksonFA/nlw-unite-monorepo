resource "digitalocean_kubernetes_cluster" "passin" {
  name    = "passin"
  region  = "nyc1"
  version = "1.29.1-do.0"

  node_pool {
    name       = "node-pool"
    size       = "s-1vcpu-2gb"
    node_count = 2
  }
}