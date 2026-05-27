# Cleanup Terraform Remote State Lab

## Destroy VM Layer

```bash
cd 02_vm
terraform destroy
```

## Destroy Networking Layer

```bash
cd ../01_networking
terraform destroy
```

## Destroy Resource Group Layer

```bash
cd ../00_rg
terraform destroy
```

---

# Delete Blob Container

```bash
az storage container delete \
  --name tfstate \
  --account-name learntfremotestate01 \
  --auth-mode login
```

---

# Delete Storage Account

```bash
az storage account delete \
  --name learntfremotestate01 \
  --resource-group learn-tf-remote-state \
  --yes
```

---

# Delete Backend Resource Group

```bash
az group delete \
  --name learn-tf-remote-state \
  --yes
```