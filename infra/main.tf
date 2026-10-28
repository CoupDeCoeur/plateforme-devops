module "cluster" {
  source = "./modules/cluster"
  nom    = var.cluster_name
}

provider "helm" {
  kubernetes {
    host                   = module.cluster.endpoint
    client_certificate     = module.cluster.client_certificate
    client_key             = module.cluster.client_key
    cluster_ca_certificate = module.cluster.cluster_ca_certificate
  }
}

module "argocd" {
  source        = "./modules/argocd"
  version_chart = var.argocd_version
  depends_on    = [module.cluster]
}
