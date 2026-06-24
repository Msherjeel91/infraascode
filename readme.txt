This Terraform project provisions a basic web application infrastructure on AWS

1 EC2 virtual machine
LAMP stack (Linux, Apache, MariaDB, PHP)
Security Group allowing:
SSH (22)
HTTP (80)
HTTPS (443)
20 GB GP3 root storage


Prerequisites

Before deployment, ensure you have:

AWS Account
AWS CLI configured
Terraform installed (v1.5 or later)
An existing AWS EC2 Key Pair

Files included are main.tf and variables.tf

Deployment Steps
1. Initialize Terraform
terraform init

Terraform downloads the required AWS provider plugins.

2. Review the Execution Plan

Replace my-keypair with your existing AWS Key Pair name.

terraform plan -var="key_name=my-keypair"
3. Deploy Infrastructure
terraform apply -var="key_name=my-keypair"

When prompted, enter:

yes

Terraform will create:

Security Group
EC2 Instance
Root EBS Volume
LAMP Stack Configuration via User Data
Accessing the Server

After successful deployment, Terraform displays outputs similar to:

public_ip = 54.xxx.xxx.xxx
owner     = sherjeel
SSH Access
ssh -i my-keypair.pem ec2-user@<public_ip>
Web Access

Open a browser and navigate to:

http://<public_ip>

Expected page:

<h1>LAMP Stack Deployed</h1>
<p>Owner: sherjeel</p>
Security Group Rules
Protocol	Port	Purpose
TCP	22	SSH Access
TCP	80	HTTP Access
TCP	443	HTTPS Access

Outbound traffic is allowed to all destinations.

Steps for deployment:
1. Initialize Terraform
terraform init

Terraform downloads the required AWS provider plugins.

2. Review the Execution Plan

Replace my-keypair with your existing AWS Key Pair name.

terraform plan -var="key_name=my-keypair"
3. Deploy Infrastructure
terraform apply -var="key_name=my-keypair"

When prompted, enter:

yes

Terraform will create:

Security Group
EC2 Instance
Root EBS Volume
LAMP Stack Configuration via User Data

Terraform Outputs

The deployment returns:

Output	Description
public_ip	Public IP address of the EC2 instance
owner	Owner name configured through Terraform variable
Cleanup

To remove all created AWS resources:

terraform destroy -var="key_name=my-keypair"


yes

This will delete the EC2 instance, associated storage, and security group.
