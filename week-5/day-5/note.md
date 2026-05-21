# GitHub OIDC + AKS kubectl Access Setup

# 1. Create Azure App Registration

```bash
APP_NAME="aks-github-oidc"

APP_ID=$(az ad app create \
  --display-name $APP_NAME \
  --query appId -o tsv)

az ad sp create --id $APP_ID
```

---

# 2. Get Tenant + Subscription IDs

```bash
TENANT_ID=$(az account show --query tenantId -o tsv)
SUBSCRIPTION_ID=$(az account show --query id -o tsv)

echo "APP_ID=$APP_ID"
echo "TENANT_ID=$TENANT_ID"
echo "SUBSCRIPTION_ID=$SUBSCRIPTION_ID"
```

---

# 3. Configure GitHub OIDC Federated Credential

```bash
GITHUB_REPO="thaunghtike-share/gitops"
BRANCH="main"

cat > credential.json <<EOF
{
  "name": "github-gitops-main",
  "issuer": "https://token.actions.githubusercontent.com",
  "subject": "repo:${GITHUB_REPO}:ref:refs/heads/${BRANCH}",
  "description": "GitHub Actions OIDC",
  "audiences": [
    "api://AzureADTokenExchange"
  ]
}
EOF

az ad app federated-credential create \
  --id $APP_ID \
  --parameters credential.json
```
---

# 4. Grant Azure AKS Access

```bash
AKS_RG="xxxx"
AKS_NAME="xxxx"

AKS_SCOPE="/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$AKS_RG/providers/Microsoft.ContainerService/managedClusters/$AKS_NAME"

az role assignment create \
  --assignee $APP_ID \
  --role "Azure Kubernetes Service Cluster User Role" \
  --scope $AKS_SCOPE
```

---

# 5. AKS RBAC Configuration

## Important

In this lab, we use Entra ID Authentication with Kubernetes RBAC .

---

# 6. Create Kubernetes ClusterRoleBinding

## Get admin kubeconfig locally

```bash
az aks get-credentials \
  --resource-group mahar \
  --name mbr \
  --admin \
  --overwrite-existing
```

## Get Service Principal ID 

az ad sp show \
  --id $APP_ID \
  --query id \
  -o tsv

## Create cluster-admin binding

```bash
kubectl create clusterrolebinding aks-github-cluster-admin \
  --clusterrole=cluster-admin \
  --user=4a15ea1d-0f6e-49ea-86f4-fd8a9fc54880
```

---

# 7. GitHub Actions Workflow

Create:

```text
.github/workflows/kubernetes.yaml
```

```yaml
name: Apply Kubernetes Manifests

on:
  push:
    branches:
      - main

permissions:
  id-token: write
  contents: read

env:
  ARM_USE_OIDC: true
  ARM_USE_AZUREAD: true
  ARM_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
  ARM_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
  ARM_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

jobs:
  test-kubectl-access:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Azure Login via OIDC
        uses: azure/login@v2
        with:
          client-id: ${{ secrets.AZURE_CLIENT_ID }}
          tenant-id: ${{ secrets.AZURE_TENANT_ID }}
          subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

      - name: Install kubectl + kubelogin
        run: |
          az aks install-cli

      - name: Get AKS credentials
        run: |
          az aks get-credentials \
            --resource-group ${{ secrets.AZURE_RESOURCE_GROUP }} \
            --name ${{ secrets.AZURE_AKS_NAME }} \
            --overwrite-existing

          kubelogin convert-kubeconfig -l azurecli

      - name: Verify cluster access
        run: |
          kubectl get nodes
```

# Final Status

```text
OIDC Login            OK
Azure Login           OK
AKS Credential Fetch  OK
kubelogin             OK
kubectl Access        OK
```