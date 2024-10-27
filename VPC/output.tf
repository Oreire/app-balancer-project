#VPC Output

output "public_subnet_1" {
    value = aws_subnet.public_subnet_1.id
 }

 output "public_subnet_2" {
    value = aws_subnet.public_subnet_2.id
}

output "private_subnet_1" {
    value = aws_subnet.private_subnet_1.id
}

output "private_subnet_2" {
    value = aws_subnet.private_subnet_2.id
}

output "aws_vpc" {
    value = aws_vpc.main.id
}
