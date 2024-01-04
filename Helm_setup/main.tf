resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  namespace        = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "1.13.0"

  wait             = true
  create_namespace = true
  force_update     = true
  replace          = true

  set {
    name  = "installCRDs"
    value = true
  }
}

resource "helm_release" "ingress-nginx" {
  name             = "ingress-nginx"
  namespace        = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  version          = "4.8.0"

  wait             = true
  create_namespace = true
  force_update     = true
  replace          = true

  //Download file (values.yaml) from official repo:
  // https://github.com/kubernetes/ingress-nginx/blob/main/charts/ingress-nginx/values.yaml
  // Add config (line 44-46)
  // Add annotation (line 444-447)
  values = [file("Helm_setup/ingress-nginx-values.yaml")] //need improvement to set only values
}
