#VPC Output

output "public_subnet_1" {
    value = aws_subnet.public_subnet_1.subnet_id
 }

 output "public_subnet_2" {
    value = aws_subnet.public_subnet_2.subnet_id
}

output "private_subnet_1" {
    value = aws_subnet.private_subnet_1.subnet_id
}

output "private_subnet_2" {
    value = aws_subnet.private_subnet_2.subnet_id
}