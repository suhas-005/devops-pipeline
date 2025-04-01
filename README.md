# **End-to-End DevOps Project on AWS**

![Architecture diagram](https://github.com/user-attachments/assets/d3497a05-62ad-49c8-a01d-c8bdc6cc1a4e)

### **Technology used:**
- Terraform
- GitHub Actions (Self-hosted runners)
- AWS (EKS - Kubernetes)
- Helm
- SonarQube
- Trivy
- NPM/Node
- Docker
- Ubuntu

### **Version used:**
-  Terraform:  v1.11.3
-  Node: v20.x
-  Helm: 3.17.1
-  Kubernetes: v1.32
-  Ubuntu - 24.04

### **How to run/deploy**

#### **Pre-requisites:**
- AWS Account and CLI setup: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html
- DockerHub account
- Create a AWS S3 for Terraform remote state storage 
- Terraform installed on local machine - https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

#### **Deploying the project:**

1. **Run terraform to spawn EC2 instance for hosting GitHub Self-hosted runner**
   ```bash
   cd terraform-github-runner
   terraform init
   terraform plan
   terraform init
   ```
   This creates an EC2 instance (t2.medium) along with a VPC, Subnet (Public), Security group, Route, Internet Gateway. It also create a IAM role with Administrator Access and attaches this to the EC2 instance (This is not recommended in production, this project only needs access to IAM, EKS, S3, VPC (includes subnets, IGW, Security groups) Administrator access is given for ease of doing project that's it)
<br>

2. **Setup GitHub Self-hosted runner**
   - SSH into the EC2 instance using the Public IP from the output of the Terraform code
     ```
     ssh -i <path to your ssh key> ubuntu@<public-ip>
     ```
   - Go to your GitHub repository and click on **Settings** tab > **Runners** > **New self-hosted runner** - https://docs.github.com/en/actions/hosting-your-own-runners/managing-self-hosted-runners/adding-self-hosted-runners
   - Run the commands mentioned on the EC2 instance, and at last run the below command to run the github runner as service
     ```bash
     sudo ./svc.sh install
     sudo ./svc.sh start
     ```
<br>

3. **Setup EKS Cluster**<br>
   Login to GitHub Runner EC2 instance again and run terraform-eks from there
   ```
   git clone https://github.com/suhas-005/devops-pipeline.git
   cd devops-pipeline/terraform-eks
   terraform init
   terraform plan
   terraform apply
   ```
   This will take around 15-20 minutes to finish
<br>

4. **Setup SonarQube**<br>
   SonarQube URL: ```<public-ip-of-ec2>:9000```<br>
   Initial username and password - ```admin```<br>
   - Reset the password
   - Then on the home page, click on ```Manually``` to create a project manually
     
     ![Sonar Project 1](https://github.com/user-attachments/assets/dff1cd4f-d686-4634-90c8-59dcc11fcb60)
     
   - Then provide a **Project display name** (Ex: devops-tic-tac-toe), **Project key**(Ex: devops-tic-tac-toe) and **Main branch name**(Ex: main)
     
   - Then on the next page click on **With GitHub Actions**
     
     ![Sonar Workflow 1](https://github.com/user-attachments/assets/440fb8e2-1cba-444f-a84a-8af9090aca39)
     
   - Then click on **Generate** to generate a **SONAR_TOKEN**, copy this token to a notepad temporarily. Also copy **SONAR_HOST_URL**
   - Then on the next step, Click on **Other**
     
     ![Sonar Workflow 2](https://github.com/user-attachments/assets/f9a034a0-7a27-4af3-a16d-992cd4aa5a60)
     
   - Then click on Finish tutorial
<br>

6. **Setup GitHub Action Secrets and Variables**
   - Go to your GitHub repository and click on **Settings** tab > **Secrets and variables** > **Actions** > **Create repository secret**
   - Create secrets for **SONAR_TOKEN**, **SONAR_HOST_URL**, **DOCKERHUB_USERNAME**  and **DOCKERHUB_TOKEN**.
   - Under Variables create variable for **IMAGE_NAME**
   - Now add a file with name **sonar-project.properties** under app-codebase directory containing the project-key obtained in the previous step while setting up SonarQube
<br>

7. **Trigger GitHub Actions**
   1. Trigger **Run checks/tests** workflow (app-ci-tests.yaml):
      - This action gets triggred when a PR is created and changes exist under app-codebase/ directory.
        ![PR](https://github.com/user-attachments/assets/213dc2fa-8eb9-464b-8adc-be43f0e8f635)
        
        ![Workflow 1](https://github.com/user-attachments/assets/8b326667-45ec-42af-9c98-26f4c2d4b988)

    2. Trigger **Build and deploy** workflow (app-cd-deploy.yaml):
       - This action gets triggered when there is a push to main branch and changes exists on app-codebase/ directory or helm-chart/ directory.
         ![Workflow 2](https://github.com/user-attachments/assets/74257a5c-f211-4f18-a94b-b03509008cd4)
<br>

8. **Access the application**
   - Once both the workflow have run successfully, we can access the application. Login to your AWS account and go to Load Balancers section There a load balancer will be created (this may take few minutes), use that URL/DNS name to access the Tic-Tac-Toe app.
     ![App](https://github.com/user-attachments/assets/42987916-a2f4-461b-ab6e-5a1431613bfa)


### **Clean up**
```
helm uninstall tic-tac-toe -n devops-project
cd terraform-eks
terraform destroy
cd terraform-github-runner
terraform destroy
```
Destroy the S3 bucket created on for strong remote state.

### Future Improvements
- CI/CD to deploy EKS
- Restrict EC2 IAM Role access
