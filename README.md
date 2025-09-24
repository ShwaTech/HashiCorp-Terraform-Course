# HashiCorp-Terraform-Course

Let's Master Terraform which is an open-source Infrastructure as Code (IaC) tool created by HashiCorp. It lets you define, provision, and manage infrastructure (like servers, databases, networks, Kubernetes clusters, etc.) using a declarative configuration language called HCL (HashiCorp Configuration Language).

## Course Outline

- ✅ Introduction to Infrastructure as Code (IaC).
- ✅ Terraform core concepts & real-world use cases.
- ✅ Terraform Components & Configuration Files.
- ✅ Terraform Providers & Authentication.
- ✅ Terraform Workflow: init, plan, apply, destroy.
- ✅ Working with Resources & Resource Dependencies.
- ✅ Output Blocks & Terraform State.
- ✅ Data Sources, Variables, and Modules.
- ✅ Best practices and tips for writing clean Terraform code.

## ⚙️ Prerequisites

- AWS account
- AWS CLI installed & configured
- Terraform installed

## Check installation

```bash
terraform -version
aws --version
```

## 🔑 Authenticating AWS Provider

Terraform uses the AWS provider to interact with your AWS resources.
You must authenticate first. Here are the main methods:

1. AWS CLI (Recommended for beginners)

```bash
aws configure
```

### Enter your credentials

```bash
AWS Access Key ID [None]: YOUR_ACCESS_KEY  
AWS Secret Access Key [None]: YOUR_SECRET_KEY  
Default region name [None]: us-east-1  
Default output format [None]: json
```

## 🚀 Terraform Commands

| Command                      | Description                     |
|------------------------------|---------------------------------|
| `terraform init`             | Initialize Terraform project    |
| `terraform validate`         | Validate `.tf` files            |
| `terraform plan`             | Show execution plan             |
| `terraform apply`            | Create/modify infrastructure    |
| `terraform destroy`          | Destroy managed infrastructure  |
| `terraform fmt`              | Format Terraform code           |
| `terraform providers`        | List providers used             |
| `terraform state list`       | View tracked resources          |
| `terraform workspace new dev`| Create a new workspace          |
