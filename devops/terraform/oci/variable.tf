variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "private_key_path" {}
variable "compartment_ocid" {}
variable "region" {}
variable "fingerprint" {}

variable "oke_cluster_name" {
  default = "Passin"
}

variable "k8s_version" {
  default = "v1.29.1"
}

variable "pool_name" {
  default = "Passin-pool"
}

variable "node_shape" {
  default = "VM.Standard1.1"
}

variable "node_ocpus" {
  default = 1
}

variable "node_memory" {
  default = 4
}

variable "node_count" {
  default = 2
}
