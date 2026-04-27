# 🚀 3-Month DevOps Mentorship Program
**Focus:** Azure, Terraform, Kubernetes (AKS), GitOps (ArgoCD), and Observability.

---

## 📅 Month 1: Advanced Terraform, Key Vault & K8s Internals
**Objective:** Master Infrastructure as Code (IaC) and secure Kubernetes deployments.

### Week 1: # Terraform Mastery: Week 1 Progress Summary

### Day 1: Enterprise Structure & Project Layout
* **Concepts:** Introduction to enterprise-grade Terraform project structures. Understanding how to separate concerns by dividing infrastructure into logical directories (e.g., `00_resource_groups`, `01_networking`, `02_compute`).
* **Key Takeaway:** Reusability is king. Using a modular approach ensures that code is not just a script, but a maintainable product.
* **Documentation:** Implementing `terraform-docs` to automatically generate `README.md` files for each module to describe inputs and outputs.

### Day 2: State Management & Remote State
* **Concepts:** Mastering the Terraform State lifecycle. Moving from local state to **Remote Backend** (Azure Storage Account) with State Locking (Blob Lease/Table Storage).
* **Deep Dive:** Using the `terraform_remote_state` data source to enable cross-folder communication.
* **Example:** Fetching Resource Group details from `00_resource_groups` to use in the networking layer without hardcoding names.

### Day 3: Advanced Data Structures & Looping
* **Concepts:** Moving beyond simple strings to complex types like `map(object({...}))`.
* **Techniques:** * **`for_each` Loop:** Automating the creation of multiple VNets and Subnets based on a single map variable.
    * **Data Transformation:** Using `flatten` and `for` loops in `outputs.tf` to clean up Raw Data into "Clean Maps" (e.g., `k => v.id`).
    * **Logic:** Converting an Object-heavy output into a simple String Map to prevent **Type Mismatch Errors** in downstream modules.

### Day 4: Common Usage & Static Resource Provisioning
* **Concepts:** Balancing Automation with Specificity. Understanding when to use `for_each` (for scaling) versus **Indexing** (for static/specific resources like an OpenVPN Server).
* **Static Referencing:**
    * Referencing specific map keys directly: `var.vms["OPENVPN-SERVER"].size`.
    * Managing **Dynamic Blocks** for security rules to handle a list of ports within a single static NSG resource.
* **Interface Standard:** Establishing a "Data Contract" where the Networking module provides IDs as Strings, and the VM module consumes them directly by key.

### Week 2: K8s Cluster Management & Lens IDE
* **Day 4: Real-World K8s Management**
    * **1-Hour Session:** Guide on how Senior Engineers interact with clusters.
    * **Offline Assignment:** Install Lens IDE. Connect to AKS and explore namespaces, core components, and nodes.
* **Day 5: K8s RBAC & Identities**
    * **1-Hour Session:** Explain Azure Managed Identities and K8s RBAC.
    * **Offline Assignment:** Write Terraform code to assign Roles so the AKS cluster can securely communicate with Azure Key Vault.
* **Day 6: Month 1 Infrastructure Review**
    * **1-Hour Session:** Strict code review of all Terraform modules.
    * **Offline Assignment:** Resolve mentor comments, destroy infrastructure, and re-apply to prove **idempotency**.

### Week 3: Helm Processing & Vault Injection
* **Day 7: Helm Charts Architecture**
    * **1-Hour Session:** Critique raw YAML vs. Helm. Explain Helm templating.
    * **Offline Assignment:** Convert application Kubernetes YAML files into a structured Helm Chart.
* **Day 8: Fetching Secrets from Vault**
    * **1-Hour Session:** Explain Azure Key Vault Provider for Secrets Store CSI Driver.
    * **Offline Assignment:** Configure Helm chart to fetch DB credentials from Key Vault and mount them as environment variables.
* **Day 9: Secrets Validation**
    * **1-Hour Session:** Verify the secret injection flow.
    * **Offline Assignment:** Use Lens to `exec` into the pod and prove the application successfully connected to the DB using Vault secrets.

### Week 4: Database Routing & Month 1 Wrap-up
* **Day 10: Dev/UAT DB on K8s**
    * **1-Hour Session:** Discuss cost-saving for non-prod environments.
    * **Offline Assignment:** Deploy a Dev/UAT database directly on AKS using **StatefulSets**.
* **Day 11: Application Routing**
    * **1-Hour Session:** Explain environment-specific configurations.
    * **Offline Assignment:** Configure Helm to support routing to in-cluster Dev DB vs. Azure Managed Prod DB based on values.
* **Day 12: K8s & Terraform Evaluation**
    * **1-Hour Session:** Final review of Month 1 setup to ensure readiness for GitOps.

---

## 📅 Month 2: Continuous Deployment & Advanced GitOps (ArgoCD)
**Objective:** Fully automate the deployment lifecycle using the GitOps philosophy.

### Week 5: Manifest Automation & ArgoCD Setup
* **Day 13: The Manifest Repository**
    * **1-Hour Session:** Explain separation of App Code vs. Manifest Repo.
    * **Offline Assignment:** Set up a dedicated K8s Manifest Repo. Write a GitHub Action to update image tags.
* **Day 14: ArgoCD Operator Deployment**
    * **1-Hour Session:** Explain GitOps principles and ArgoCD architecture.
    * **Offline Assignment:** Install ArgoCD Operator on AKS and local CLI. Connect ArgoCD to the Manifest Repo.
* **Day 15: ArgoCD UI & Application Creation**
    * **1-Hour Session:** Guide through the ArgoCD UI.
    * **Offline Assignment:** Deploy the first application via ArgoCD UI and observe the initial sync.

### Week 6: Advanced ArgoCD Patterns
* **Day 16: Parent/Child App Sync Pattern**
    * **1-Hour Session:** Discuss enterprise multi-app deployments.
    * **Offline Assignment:** Implement "App of Apps" pattern (Root app detecting changes for child microservices).
* **Day 17: Desired State Reconciliation**
    * **1-Hour Session:** Live test of ArgoCD drift detection.
    * **Offline Assignment:** Manually delete a deployment via Lens; document how ArgoCD automatically restores the state.
* **Day 18: Health Validation**
    * **1-Hour Session:** Explain how ArgoCD determines app health.
    * **Offline Assignment:** Intentionally break a readiness probe and observe Health Validation failure.

### Week 7 & 8: GitOps Deep Dive & Flow Mastery
* **Day 19: Managing Helm via ArgoCD**
    * **1-Hour Session:** Explain dynamic Helm value processing in ArgoCD.
    * **Offline Assignment:** Pass environment-specific values (Dev vs. Prod) during sync.
* **Day 20: ArgoCD Sync Waves & Hooks**
    * **1-Hour Session:** Discuss deployment ordering.
    * **Offline Assignment:** Implement Sync Waves to ensure DB initializes before the App starts.
* **Day 21-24: End-to-End Troubleshooting**
    * **1-Hour Sessions:** Mentor intentionally breaks sync or Vault policies.
    * **Offline Assignments:** Troubleshoot, fix, and ensure the pipeline is production-ready.

---

## 📅 Month 3: Observability Stack & Incident Management
**Objective:** Build robust logging/monitoring and interview confidence.

### Week 9: Log Aggregation (Loki Stack)
* **Day 25: Deploying Loki Alloy**
    * **1-Hour Session:** Observability concepts and unified agents.
    * **Offline Assignment:** Deploy Loki Alloy on AKS to scrape metrics and logs.
* **Day 26: Deploying Loki**
    * **1-Hour Session:** Log stream storage architecture.
    * **Offline Assignment:** Deploy Loki to aggregate streams forwarded by Alloy.
* **Day 27: Log Querying via Grafana**
    * **1-Hour Session:** Explain LogQL.
    * **Offline Assignment:** Build a Grafana dashboard querying application logs.

### Week 10: Monitoring, Metrics & Webhooks
* **Day 28: Prometheus Integration**
    * **1-Hour Session:** Time-series metrics.
    * **Offline Assignment:** Deploy Prometheus via Alloy. Build Grafana dashboards for CPU/Memory.
* **Day 29: Alertmanager Configuration**
    * **1-Hour Session:** Incident response and routing.
    * **Offline Assignment:** Configure Alertmanager for `HighCPU` or `CrashLoopBackOff` alerts.
* **Day 30: Google Chat Webhook Integration**
    * **1-Hour Session:** Webhook mechanics.
    * **Offline Assignment:** Connect Alertmanager to Google Chat. Test by spiking CPU.

### Week 11: Real-World Chaos Engineering
* **Day 31: Scenario 1 - Key Vault Outage**
    * **1-Hour Session:** Revoke AKS access to Key Vault.
    * **Offline Assignment:** Use logs/ArgoCD to find the cause, fix RBAC, and write an RCA.
* **Day 32: Scenario 2 - CrashLoop & Alerting**
    * **1-Hour Session:** Deploy a broken image tag.
    * **Offline Assignment:** Acknowledge alert, trace logs, rollback in ArgoCD, and document.
* **Day 33: Operations Post-Mortem**
    * **1-Hour Session:** Mock CTO review of incident response and production communication.

### Week 12: Interview Prep & Professional Polish
* **Day 34: System Design Interview Prep**
    * **1-Hour Session:** Whiteboard techniques for the full architecture.
    * **Offline Assignment:** Practice explaining the end-to-end flow.
* **Day 35: Mock Technical Interview**
    * **1-Hour Session:** Q&A on State locks, GitOps reconciliation, and CSI drivers.
* **Day 36: Final Handoff & Career Strategy**
    * **1-Hour Session:** Final review and actionable steps for the Ireland job market.