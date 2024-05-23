output "vpc_network_name" {
  value       = data.google_compute_network.vpc_network.name
  description = "The name of the VPC network"
}
