# Terraform Module Demo

This lab uses one root module with separated root files.

- Local child module: `./modules/rg`
- Remote / published module: `Azure/avm-res-network-virtualnetwork/azurerm`
- Backend: Azure Blob Storage
- Root resources are separated into `rg.tf`, `vnet.tf`, `acr.tf`, and `vm.tf`

## Folder Structure

```text
terraform-module-demo/
├── providers.tf
├── rg.tf
├── vnet.tf
├── acr.tf
├── vm.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars.example
└── modules/
    └── rg/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## How To Run

```bash
cp terraform.tfvars.example terraform.tfvars
```

Update this value in `terraform.tfvars`.

```hcl
vm_ssh_public_key = "ssh-rsa REPLACE_WITH_YOUR_PUBLIC_KEY"
```

Then run:

```bash
terraform init
terraform plan
terraform apply
```

## Clean Up

```bash
terraform destroy
```
