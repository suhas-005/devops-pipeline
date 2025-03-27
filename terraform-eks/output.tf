output "EKS_CLUSTER_NAME" {
    description = "AWS EKS Cluster Name"
    value = module.eks.cluster_name
}

output "EKS_CLUSTER_ENDPOINT" {
    description = "Endpoint for AWS EKS"
    value = module.eks.cluster_endpoint
}