output "cluster_id" {
  value = azurerm_kubernetes_cluster.aks_cluster.id
}

output "cluster_name" {
  value = azurerm_kubernetes_cluster.aks_cluster.name
}

output "node_reasource_group" {
  value = azurerm_kubernetes_cluster.aks_cluster.node_resource_group
}

output "kube_config_raw" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
}

output "key_vault_identity_object_id" {
  value = azurerm_kubernetes_cluster.aks_cluster.key_vault_secrets_provider[0].secret_identity[0].object_id
}