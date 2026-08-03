🌐 Terraform VPC Infrastructure on AWS (Local Dev with Floci)
<p align="center"> <img src="https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white" /> <img src="https://img.shields.io/badge/AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white" /> <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" /> <img src="https://img.shields.io/badge/Floci-Local%20Emulator-4CAF50?style=for-the-badge" /> </p>



📌 Overview

This project provisions a production-grade AWS VPC infrastructure using Terraform, running entirely locally via Floci — a local AWS cloud emulator powered by Docker.

The goal is to demonstrate Infrastructure as Code (IaC) best practices by building a full network topology with:

Public/private subnet separation across two Availability Zones
NAT Gateway for secure outbound internet access from private subnets
Internet Gateway for inbound/outbound access in public subnets
Proper route table architecture with subnet associations



🏗️ Architecture

                            Internet
                               │
                    ┌──────────▼──────────┐
                    │   Internet Gateway  │
                    └──────────┬──────────┘
                               │
         ┌─────────────────────▼─────────────────────┐
         │               VPC  10.0.0.0/16            │
         │                                           │
         │   ┌─────────────────┐  ┌─────────────────┐│
         │   │  Public Subnet 1│  │  Public Subnet 2││ 
         │   │  10.0.1.0/24    │  │  10.0.3.0/24    ││
         │   │  us-east-1a     │  │  us-east-1b     ││
         │   └────────┬────────┘  └─────────────────┘│
         │            │ Public Route Table           │
         │            │ 0.0.0.0/0 ──► IGW            │
         │   ┌────────▼────────┐                     │
         │   │   NAT Gateway   │                     │
         │   │  + Elastic IP   │                     │
         │   └────────┬────────┘                     │
         │            │ Private Route Table          │
         │            │ 0.0.0.0/0 ──► NAT GW         │
         │   ┌────────▼────────┐  ┌─────────────────┐│
         │   │ Private Subnet 1│  │ Private Subnet 2││ 
         │   │  10.0.2.0/24    │  │  10.0.4.0/24    ││
         │   │  us-east-1a     │  │  us-east-1b     ││
         │   └─────────────────┘  └─────────────────┘│
         └───────────────────────────────────────────┘



Resources Provisioned

Resource		    Count
VPC		 	      1
Public Subnets	  	      2
Private Subnets	  	      2
Internet Gateway  	      1
NAT Gateway	  	      1
Elastic IP	  	      1
Route Tables	  	      2
Route Table Associations      4


🌍 Network Design
VPC
Property	Value
CIDR Block	10.0.0.0/16
Region	        us-east-1

Public Subnets
Name			CIDR Block    	     Availability Zone	    Auto-Assign Public IP
Public Subnet 1		10.0.1.0/24		us-east-1a		  ✅ Enabled
Public Subnet 2		10.0.3.0/24		us-east-1b		  ✅ Enabled

Private Subnets
Name			CIDR Block	     Availability Zone       Auto-Assign Public IP
Private Subnet 1	10.0.2.0/24	 	us-east-1a		  ❌ Disabled
Private Subnet 2	10.0.4.0/24		us-east-1b		  ❌ Disabled



🔀 Routing
Route Table	Destination	Target	Associated Subnets
Public RT	0.0.0.0/0	Internet Gateway	Public Subnet 1, Public Subnet 2
Private RT	0.0.0.0/0	NAT Gateway	Private Subnet 1, Private Subnet 2



✅ Prerequisites
Tool	Purpose	Install
Terraform >= 1.0	Infrastructure provisioning	Download
Docker	Required by Floci	Download
Floci	Local AWS emulator	floci.dev
AWS CLI (optional)	Inspect outputs manually	Download



🚀 Getting Started
1. Clone the Repository
bash
git clone https://github.com/M0az2/floci-lab.git
cd floci-lab
2. Start Floci
bash
floci start
3. Initialize Terraform
bash
terraform init
4. Review the Execution Plan
bash
terraform plan
5. Apply the Infrastructure
bash
terraform apply
6. Tear Down (when done)
bash
terraform destroy


📁 Project Structure
.
├── .gitignore             # Ignores state files and .terraform/ directory
├── .terraform.lock.hcl    # Locks provider versions (committed intentionally)
├── docker-compose.yml     # Floci local AWS emulator setup
├── provider.tf            # AWS provider config pointing to Floci endpoint
├── vpc.tf                 # VPC resource definition
├── subnets.tf             # Public and private subnet resources
├── igw.tf                 # Internet Gateway
├── nat.tf                 # NAT Gateway + Elastic IP
├── route_tables.tf        # Route tables and subnet associations
├── variables.tf           # Input variable declarations
├── terraform.tfvars       # Variable values (safe to commit — no secrets)
└── outputs.tf             # Exported output values




⚙️ Configuration Variables

All variables are defined in terraform.tfvars. No secrets or credentials are stored here.

Variable		Value		Description
------------------------------------------------------------------
region			us-east-1	AWS region
vpc_cidr		10.0.0.0/16	VPC CIDR block
project_name		floci-lab	Project tag name
public_subnet_1		10.0.1.0/24	Public subnet 1 CIDR
public_subnet_2		10.0.3.0/24	Public subnet 2 CIDR
private_subnet_1	10.0.2.0/24	Private subnet 1 CIDR
private_subnet_2	10.0.4.0/24	Private subnet 2 CIDR
az1			us-east-1a	Availability Zone 1
az2			us-east-1b	Availability Zone 2
internet_cidr		0.0.0.0/0	Default route for internet


🛠️ Terraform Commands
bash
# Initialize providers and backend
terraform init

# Format all .tf files
terraform fmt

# Validate configuration syntax
terraform validate

# Preview infrastructure changes
terraform plan

# Apply and provision infrastructure
terraform apply

# Destroy all provisioned resources
terraform destroy



📤 Outputs

After a successful terraform apply, the following values are exported:

Output			    Description
-----------------------------------------------------
vpc_id			ID of the created VPC
internet_gateway_id	ID of the Internet Gateway
nat_gateway_id		ID of the NAT Gateway
public_subnet_ids	List of public subnet IDs
private_subnet_ids	List of private subnet IDs
public_route_table_id	ID of the public route table
private_route_table_id	ID of the private route table
