# Creating an RKE2 Cluster using Rancher Cluster Management and Hetzner Cloud

This comprehensive guide is divided into three distinct parts, each crucial for creating a robust RKE2 (Rancher Kubernetes Engine 2) cluster. We will begin by setting up Rancher Cluster Management, followed by provisioning Hetzner Cloud nodes, and finally, we will install the necessary Helm charts to enhance cluster functionality. 
This process will result in a fully functional RKE2 cluster managed by Rancher and hosted on Hetzner Cloud infrastructure.



## Prerequisites

Before embarking on this journey, ensure you have the following prerequisites:

- 1password cli logged in
- Hetzner Cloud Account: An active Hetzner Cloud account is essential to create and manage virtual machines (VMs). You will need both a Hetzner Cloud account and an API token.
- Rancher Cluster Management: Make sure you have Rancher Cluster Management installed and correctly configured. You will also need an API token for Rancher Cluster Management.


## Setting Up Rancher Cluster Management
In this section, we will set up Rancher Cluster Management to facilitate the management of our RKE2 cluster. Rancher Cluster Management provides an intuitive interface for Kubernetes cluster orchestration.

To interact with Rancher Cluster Management programmatically, you will need an API token. If you don't already have one, here's how to create and configure it:

- Log in to your Rancher Cluster Management interface.
- Click on your username in the top-right corner and select "API & Keys" from the dropdown menu.
- Click "Add API Key" and give it a name, such as "Rancher-API-Key."
- Select the desired permissions for the API key. For this guide, you may need full cluster management permissions.
- Click "Create" to generate the API key.
- Copy the generated API key and store it securely. You will need it to authenticate with Rancher Cluster Management.
- Create file terrafom.tfvars (look terraform.tfstate.example) and add values: api_url,rancher2_access_key,rancher2_secret_key

The Terraform script will create an RKE2 cluster with the following settings:

- External Cloud Provider
- CNI (Container Network Interface): Calico
- CIS (Center for internet security best practices)
- Custom upgrade strategy

## Provisioning Hetzner Cloud Nodes

Part 2 focuses on automating the creation of VMs on Hetzner Cloud. We will utilize Terraform to define and deploy our infrastructure.

Before proceeding, you need to create an API token in your Hetzner Cloud account. This token will be used to programmatically create VMs on the Hetzner Cloud platform. Here's how to do it:

- Log in to your Hetzner Cloud account.
- Go to "Account" in the top-right corner of the Hetzner Cloud console.
- Select "API Tokens" from the dropdown menu.
- Click on "Create API Token."
- Give your token a name and specify any desired permissions.
- Click "Create" to generate the API token.

We'll automate the creation of Hetzner Cloud nodes and set up various components. The process involves creating a Virtual Private Network (VPC), Subnet, Servers, and a Load Balancer. We will also SSH into the nodes and register them with your RKE2 cluster. Additionally, we will install and configure Hetzner Cloud Controller Manager and follow best practices, including Center for Internet Security (CIS) recommendations.

### Step 1: Create Virtual Private Network (VPC) and Subnet
Using Terraform or the Hetzner Cloud dashboard, create a Virtual Private Network (VPC) if it's not already set up. Configure it to match your network requirements.

Within the VPC, create a Subnet to define the IP address range and routing within your private network.

### Step 2: Create Servers (Nodes)
Use Terraform or other automation tools to create Hetzner Cloud Servers (nodes) within your Subnet. These servers will be the worker nodes of your RKE2 cluster.

Ensure that you configure the nodes with the appropriate SSH keys, so you can access them securely.

### Step 3: Set Up Load Balancer
Configure a Load Balancer within your Hetzner Cloud environment to distribute traffic to the worker nodes. This Load Balancer will be used to balance the workload across your cluster.

### Step 4: SSH into the Nodes and Register Them
SSH into each Hetzner Cloud node using the provided SSH key and register them with custom cluster register command (which token is generated in previous part statefile - Rancher_cluster_setup/terraform.tfstatefile).

### Step 5: Install Hetzner Cloud Controller Manager and CIS on all_roles_master
Within your RKE2 cluster, you can install the Hetzner Cloud Controller Manager. This component allows for seamless integration with Hetzner Cloud's features and resources.
Follow best practices and security guidelines, including CIS recommendations, to enhance the security of your RKE2 cluster. This may include setting kernel parameters, implementing pod security policies, and configuring network policies.

## Creating and Managing Your Cluster

To create your RKE2 cluster, simply run the create_cluster.sh script or you run seperatly step by step in both of created directories terraform init and terraform apply. This script automates the entire process, including infrastructure provisioning and RKE2 cluster configuration:

   ```shell
   chmod +x create-cluster.sh
   ./create-cluster.sh
   ```

To destroy your RKE2 cluster at the end of this guide, run command: 

   ```shell
   chmod +x destroy-cluster.sh
   ./destroy-cluster.sh
   ```

### Installing Helm Charts

The Terraform configurations in the respective directory include Helm chart installations. After setting up your RKE2 cluster and Hetzner Cloud nodes using Terraform, Helm charts can be installed as part of the automated process.
As part of the Helm chart installations, Cert-Manager and Ingress-Nginx will be automatically deployed to your RKE2 cluster.

## Conclusion
Setting up an RKE2 cluster using Rancher Cluster Management, Hetzner Cloud nodes, and Helm charts is a comprehensive process that provides you with a powerful and flexible Kubernetes environment. In this guide, we've covered the essential steps to create and manage your cluster. Here's a summary of what you've accomplished:

- Rancher Cluster Management: You have successfully set up Rancher Cluster Management, which serves as the control plane for your RKE2 cluster. This user-friendly interface simplifies Kubernetes cluster management.

- Hetzner Cloud Nodes: Through Terraform automation, you've created Hetzner Cloud infrastructure components, including Virtual Private Networks (VPCs), Subnets, Servers, and Load Balancers. These resources are the foundation of your Kubernetes cluster.

- Cluster Installation: Using Terraform, you've automated the installation of your RKE2 cluster, including crucial configurations and settings. This approach ensures consistency and reduces manual errors.

- Helm Charts: Helm charts are a vital part of your cluster's functionality. By automating their installation using Terraform, you've added essential components like Cert-Manager and Ingress-Nginx, which enhance security and external access for your applications.

By following this guide, you've created a robust and secure RKE2 cluster with Rancher Cluster Management on Hetzner Cloud infrastructure. This setup allows you to deploy and manage Kubernetes workloads effectively, making it easier to run and scale your containerized applications.
