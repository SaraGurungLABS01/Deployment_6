# Purpose

This documentation serves the essential purpose of facilitating the deployment and effective management of the Retail Banking platform. It encompasses a comprehensive set of tasks and procedures, ranging from Git version control and Jenkins automation to AWS resource configuration and database integration. The document offers a clear roadmap for setting up the underlying infrastructure and deploying the application, with a focus on creating and managing Git branches tailored to different regions. It also emphasizes the secure configuration of AWS credentials within Jenkins for streamlined automation. This guide provides detailed insights and step-by-step instructions to ensure a seamless and well-managed deployment process, catering to the unique demands of the Retail Banking platform.# Steps

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

## Configure AWS credentials in Jenkins 

To securely configure AWS credentials in Jenkins for the automation purpose, please refer to the following link for step-by-step instructions: [How to Configure AWS credentials in  Jenkins](https://scribehow.com/shared/How_to_Securely_Configure_AWS_Access_Keys_in_Jenkins__MNeQvA0RSOWj4Ig3pdzIPw)https://scribehow.com/shared/How_to_Securely_Configure_AWS_Access_Keys_in_Jenkins__MNeQvA0RSOWj4Ig3pdzIPw

Configuring AWS credentials in Jenkins is essential as it enables the integration of AWS services with your automation tasks, ensuring secure access to resources. This configuration enhances security by managing access keys within Jenkins, reducing unauthorized access risks, and streamlines automation, allowing Jenkins to efficiently perform AWS-related tasks in your workflows, ultimately improving productivity and facilitating seamless cloud operations.

## Create a Different Git Branch for the us-west-2

In this deployment, Git is leveraged for creating dedicated branches, each functioning as an isolated repository for the application's source code across various regions. Every branch is meticulously structured to house a single Terraform file, streamlining the process of implementing region-specific alterations. This approach not only ensures efficient management of region-specific changes but also enables a versatile development process, adaptable to the unique requirements of any region.
the main purpose for this is to serve

```shell
git checkout main
 ```
```shell
 git checkout -b second-west
```

## Creating a multibranch pipeline and running the Jenkinsfile

Created a multi branch pipeline to run the Jenkinsfile and deploy the Retail Banking application across all the instances in us-east-1 and us-west-2

Result: Successful

<img width="971" alt="Screen Shot 2023-10-30 at 2 21 07 AM" src="https://github.com/SaraGurungLABS01/Deployment_6/assets/140760966/998e013c-0226-48f5-b16c-ec7cccd93031">

<img width="1252" alt="Screen Shot 2023-10-30 at 2 24 18 AM" src="https://github.com/SaraGurungLABS01/Deployment_6/assets/140760966/6ef82bae-8634-4fa6-8943-1a2e397594ac">


## Application load balancer for us-east-1 and us-west-2

A load balancer plays a pivotal role in distributing network traffic efficiently across multiple servers or resources. Its importance lies in enhancing system availability, reliability, and scalability. By evenly distributing incoming requests, load balancers prevent server overloads, reduce downtime, and provide a seamless user experience, crucial for high-performance applications and websites. Moreover, load balancers improve security, as they can detect and mitigate malicious traffic. In essence, load balancers are a fundamental component for maintaining the performance and dependability of modern web applications and services.

## Application Load Balancer for us-east-1 and us-west-2

To efficiently manage and distribute traffic across your application's instances in both the us-east-1 and us-west-2 regions, an Application Load Balancer with Target Groups is set up. This component ensures high availability and scalability of your application.

For detailed instructions on creating an Application Load Balancer with Target Groups for EC2 instances, please refer to the following link:

[Creating Load Balancer with Target Groups for EC2 Instances](https://scribehow.com/shared/Creating_Load_Balancer_with_Target_Groups_for_EC2_Instances__WjPUNqE4SLCpkcYRouPjjA)

