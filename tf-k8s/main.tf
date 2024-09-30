provider "kubernetes" {
  host                   = var.kubernetes_host
  client_certificate     = base64decode(var.kubernetes_client_certificate)
  client_key             = base64decode(var.kubernetes_client_key)
  cluster_ca_certificate = base64decode(var.kubernetes_cluster_ca_certificate)
}

resource "kubernetes_manifest" "namespace" {
  manifest = yamldecode(file("${path.module}/k8s-manifests/namespace.yaml"))
}

resource "kubernetes_manifest" "redis-volume" {
  manifest = yamldecode(file("${path.module}/k8s-manifests/redis-pvc.yaml"))

  depends_on = [
    kubernetes_manifest.namespace
  ]
}

resource "kubernetes_manifest" "redis-db" {
  manifest = yamldecode(file("${path.module}/k8s-manifests/redis-deployment.yaml"))

  depends_on = [
    kubernetes_manifest.redis-volume,
    kubernetes_manifest.namespace
  ]
}

resource "kubernetes_manifest" "redis-db-service" {
  manifest = yamldecode(file("${path.module}/k8s-manifests/redis-service.yaml"))

  depends_on = [
    kubernetes_manifest.namespace
  ]
}

resource "kubernetes_manifest" "flask-app-configmap" {
  manifest = yamldecode(file("${path.module}/k8s-manifests/flask-app-configmap.yaml"))

  depends_on = [
    kubernetes_manifest.namespace
  ]
}

resource "kubernetes_manifest" "flask-app-deployment" {
  manifest = yamldecode(file("${path.module}/k8s-manifests/flask-app-deployment.yaml"))

  depends_on = [
    kubernetes_manifest.flask-app-configmap,
    kubernetes_manifest.namespace
  ]
}

resource "kubernetes_manifest" "flask-app-service" {
  manifest = yamldecode(file("${path.module}/k8s-manifests/flask-app-service.yaml"))

  depends_on = [
    kubernetes_manifest.namespace
  ]
}
