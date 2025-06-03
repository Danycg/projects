# ChatGPT
provider "aws" {
  region = "us-east-1" # Cambia si necesitas otra región
}

# VPC
resource "aws_vpc" "mentoria_vpc" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "MENTORIA-VPC"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.mentoria_vpc.id

  tags = {
    Name = "MENTORIA-IGW"
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.mentoria_vpc.id
  cidr_block              = "10.1.111.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "MENTORIA-Public-Subnet"
  }
}

# Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.mentoria_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "MENTORIA-Public-RT"
  }
}

resource "aws_route_table_association" "public_rta" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Security Group
resource "aws_security_group" "dc_sg" {
  name        = "mentoria-dc-sg"
  description = "Allow RDP"
  vpc_id      = aws_vpc.mentoria_vpc.id

  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Cámbialo por tu IP si quieres mayor seguridad
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MENTORIA-SG"
  }
}

# Windows Server Instance con promoción a Domain Controller
resource "aws_instance" "windows_dc" {
  ami                         = "ami-0db3480be03d8d01c" # Windows Server 2022 Base (us-east-1)
  instance_type               = "t2.medium"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.dc_sg.id]
  associate_public_ip_address = true
  key_name                    = "vockey" # REEMPLAZAR por tu Key Pair

  user_data = <<-EOF
              <powershell>
              # Descargar e instalar Google Chrome
              $ChromeInstaller = "$env:TEMP\\chrome_installer.exe"
              Invoke-WebRequest -Uri "https://dl.google.com/chrome/install/latest/chrome_installer.exe" -OutFile $ChromeInstaller
              Start-Process -FilePath $ChromeInstaller -Args "/silent /install" -Wait
              
              Rename-Computer -NewName "CERVER" -DomainCredential dominio\usuario -Restart

              /*
              Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

              $SafeModePW = ConvertTo-SecureString "ComplexP@ssw0rd!" -AsPlainText -Force

              Install-ADDSForest `
                -DomainName "MENTORIA.ELX" `
                -DomainNetbiosName "MENTORIA" `
                -SafeModeAdministratorPassword $SafeModePW `
                -InstallDNS `
                -Force

              Start-Sleep -Seconds 300

              Add-LocalGroupMember -Group "Administrators" -Member "MENTORIA\\Administrator"
              */
              </powershell>
              EOF
              
              
              

  tags = {
    Name = "MENTORIA-DC"
  }
}

