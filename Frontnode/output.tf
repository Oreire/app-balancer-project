output "instance-id_1" {
  value = aws_subnet.public_subnet_1.id
}

output "frontnode_1_id" {
  description = "Target Group 1"
  value       = module.vpc.vpc_id
}
output "frontnode_2_id" {
  description = "Target Group 2"
  value       = module.vpc.vpc_id
}
