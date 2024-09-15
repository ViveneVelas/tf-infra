
# Infraestrutura Terraform para AWS

Este repositório contém um conjunto de scripts Terraform para provisionar uma infraestrutura básica na AWS. O objetivo é criar uma configuração que inclui instâncias EC2, VPC, subnets, RDS e um bucket S3. <br> <br>

<p align = "center">
<img src="https://img.shields.io/static/v1?label=STATUS&message=EM%20ANDAMENTO&color=yellow&style=for-the-badge"/>
</p>

## Pré-requisitos
Antes de começar, verifique se você tem os seguintes pré-requisitos instalados:

Terraform (versão 1.2.0 ou superior)
Conta na AWS com permissões adequadas para criar e gerenciar recursos

<br>

## Configuração

Clone o repositório:
git clone https://github.com/ViveneVelas/tf-infra.git
<br><br>

## Inicialize o Terraform:
Execute o comando abaixo para inicializar o diretório do Terraform e baixar os plugins necessários: <br>
terraform init
<br><br>

## Estrutura do Código

- Providers: Utiliza o provider AWS (hashicorp/aws) para interagir com a AWS. <br>
- VPC: Cria uma VPC com o CIDR 10.0.0.0/16. <br>
- Subnets: Cria subnets públicas e privadas em diferentes zonas de disponibilidade. <br> 
- Internet Gateway: Cria um gateway de internet e o associa à VPC. <br>
- Route Table: Define uma tabela de rotas para permitir acesso à internet a partir das subnets públicas. <br>
- EC2 Instances: Provisiona instâncias EC2 públicas (para FrontEnd e Bastion Host) e privadas (para Backend). <br>
- RDS: Cria uma instância RDS MySQL e uma subnet group associada. <br>
- Security Groups: Define um grupo de segurança para a instância RDS. <br>
- S3 Bucket: Cria um bucket S3 com um nome específico. <br>

<br><br>

## Recursos Criados

### Instâncias EC2

- ec2-public: Instância pública para FrontEnd e Bastion Host.
- ec2-private: Instância privada para Backend.

### VPC e Subnets

- VPC com CIDR 10.0.0.0/16.

### Subnets públicas e privadas distribuídas em zonas de disponibilidade.

### Internet Gateway e Tabela de Roteamento

- Internet Gateway associado à VPC.

### Tabela de rotas para fornecer acesso à internet para as subnets públicas.

### RDS (MySQL)
- Instância MySQL RDS em uma subnet privada.
- Grupo de subnets associado à instância RDS.

### S3 Bucket
- Bucket S3 para armazenamento de objetos.

