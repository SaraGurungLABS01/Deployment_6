# Purpose

# Steps

## Downloading and uploading the files to a new repository

1. **Clone the source repository:**
   - Clone the repository with `git clone https://github.com/kura-labs-org/c4_deployment-6.git`.

2. **Navigate to the cloned directory:**
   - Change to the repository directory with `cd c4_deployment-6`.

3. **Set up a new GitHub repository:**
   - Create a new GitHub repository with the desired settings.

4. **Point your local repository to the new GitHub repository:**
   - Update the remote URL with `git remote set-url origin https://github.com/SaraGurungLABS01/Deployment_6.git`.

5. **Push your local files to the new repository:**
   - Push your local files to the new repository using `git push -u origin main --force`.
  
## Building Jenkins Infrastructure using Terraform

 Terraform was used to create a Jenkins manager and agent architecture within a default VPC. The `main.tf` and `variables.tf` files in this repository play a crucial role in defining the AWS resources to be created and declaring variables for configuration. Let's take a closer look at the `main.tf` file by [main.tf](https://github.com/SaraGurungLABS01/Deployment_6.git/main.tf). 
 
**Prerequisites**
Before proceeding, ensure you have the following software installed:
- Terraform
- Default Java Runtime Environment (default-jre)

**Instance 1 (Jenkins Manager) requires the following software:**
- Jenkins
- software-properties-common
- add-apt-repository -y ppa:deadsnakes/ppa
- Python 3.7 and dependencies

**Instance 2 (Jenkins Agent) requires the following software:**
- Terraform
- Default Java Runtime Environment (default-jre)

## Key Pairs for EC2 Instances

To deploy EC2 instances in both the `us-east-1` and `us-west-2` regions, two key pairs were required to be created for secure access. Key pairs are essential for securely connecting to your instances via SSH. 

**Steps : using AWS Management Console**
   - Log in to the AWS Management Console for the `us-east-1` or `us-west-2`region.
   - Navigate to the EC2 service.
   - In the EC2 Dashboard, under the "Network & Security" section, select "Key Pairs" from the left sidebar.
   - Click the "Create Key Pair" button.
   - Provide a name for the key pair, for example, "us-east-1-keypair," and select the "RSA" key pair type.
   - Click the "Create Key Pair" button.

## Jenkins Agents

Jenkins, a versatile open-source automation server, serves as a powerful tool for building, testing, and deploying code while efficiently distributing workloads. In this context, we're utilizing Jenkins Agents to automate Terraform steps for provisioning our infrastructure.

### Creating a New Jenkins Agent Node

[Step-by-Step Guide - Creating an Agent in Jenkins](https://scribehow.com/shared/Step-by-step_Guide_Creating_an_Agent_in_Jenkins__xeyUT01pSAiWXC3qN42q5w)

## Infrastructure Setup and Application Deployment

By utilizing Jenkins Agents, we streamline the provisioning process, enhance resource utilization, and improve the overall efficiency of the infrastructure setup.

This section outlines the steps to create two Virtual Private Clouds (VPCs) in different regions and provision the necessary components within each VPC. 

### Step 1: Create VPCs and Components

#### VPC in US-east-1 & US-west-2

Use Terraform to create a VPC in the given regions with the following components:

- 2 Availability Zones (AZs)
- 2 Public Subnets
- 2 EC2 Instances
- 1 Route Table
- Security Group allowing incoming traffic on ports 22 (SSH) and 8000 (for the application).

### Step 2: User Data Script

For each EC2 instance within the VPCs, refer to the existing `appsetup.sh` script to install the required dependencies and deploy the Banking application. 


## Creating an RDS Database

Please refer to the following link for step-by-step instructions:

[How to Create an AWS RDS Database](https://scribehow.com/shared/How_to_Create_an_AWS_RDS_Database__zqPZ-jdRTHqiOGdhjMI8Zw)

## Updating Database Endpoints

To ensure seamless functionality between your application and the AWS RDS database an update to the MySQL endpoints in your application files was made. By making these adjustments, a secure connection was established to the RDS database, allowing the application to efficiently store, retrieve, and manage data. Key areas to modify include the `DATABASE_URL` configuration in the application files, `database.py`, `load_data.py`, and `app.py`. This ensures that the application operates correctly and utilizes the RDS database effectively, enabling smooth data management and proper application functionality.
