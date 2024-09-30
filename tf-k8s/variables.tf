variable "kubernetes_host" {
  description = "The API server address of the Kubernetes cluster"
  type        = string
}

variable "kubernetes_client_certificate" {
  description = "Base64 encoded client certificate for authentication"
  type        = string
}

variable "kubernetes_client_key" {
  description = "Base64 encoded client key for authentication"
  type        = string
}

variable "kubernetes_cluster_ca_certificate" {
  description = "Base64 encoded CA certificate for the Kubernetes cluster"
  type        = string
}

