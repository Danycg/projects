output "mentoria_vpc" {
  description = "ID de la VPC creada"
  value       = aws_vpc.mentoria_vpc.id
}

output "public_subnet" {
  description = "ID de la subred creada"
  value       = aws_subnet.public_subnet.id
}

output "windows_dc_publica" {
  description = "Dirección IP pública de la instancia EC2"
  value       = aws_instance.windows_dc.public_ip
}

output "windows_dc_privada" {
  description = "Dirección IP privada de la instancia EC2"
  value       = aws_instance.windows_dc.private_ip
}
