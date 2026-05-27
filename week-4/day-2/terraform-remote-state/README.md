# Terraform Remote State Lab - Azure Blob Storage

# Step 1 - Login To Azure

```bash
az login
```

---

# Step 2 - Create Resource Group

```bash
az group create \
  --name learn-tf-remote-state \
  --location southeastasia
```

---

# Step 3 - Create Storage Account

```bash
az storage account create \
  --name learntfremotestate01 \
  --resource-group learn-tf-remote-state \
  --location southeastasia \
  --sku Standard_LRS \
  --kind StorageV2
```

---

# Step 4 - Create Blob Container

```bash
az storage container create \
  --name tfstate \
  --account-name learntfremotestate01 \
  --auth-mode login
```
---

# Step 5 - Give Permissions To Current User

With use_azuread_auth = true, Terraform uses Azure AD token directly Requires **Storage Blob Data Contributor** 

```bash
az role assignment create \
  --assignee $(az ad signed-in-user show --query id -o tsv) \
  --role "Storage Blob Data Contributor" \
  --scope $(az storage account show \
    --name learntfremotestate01 \
    --resource-group learn-tf-remote-state \
    --query id -o tsv)
```
---

# Terraform Backend Configuration

## providers.tf

```hcl
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "learn-tf-remote-state"
    storage_account_name = "learntfremotestate01"
    container_name       = "tfstate"
    key                  = "00_rg/terraform.tfstate"
    use_azuread_auth     = true
  }
}

provider "azurerm" {
  features {}
}
```

---

# Terraform Commands

## Initialize Terraform

```bash
terraform init
```

## Validate Terraform

```bash
terraform validate
```

## Check Execution Plan

```bash
terraform plan
```

## Apply Configuration

```bash
terraform apply
```

## Destroy Resources

```bash
terraform destroy
```

---

# Terraform State Commands

## List Resources

```bash
terraform state list
```

## Show Resource Details

```bash
terraform state show azurerm_resource_group.rg
```

## Pull Remote State

```bash
terraform state pull
```

---

# Expected Result

Terraform state file will be stored in Azure Blob Storage:

```text
00_rg/terraform.tfstate
```
