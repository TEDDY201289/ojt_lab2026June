# 🚀 3-Month DevOps Mentorship Program
**Focus:** Azure, Terraform, Kubernetes (AKS), GitOps (ArgoCD), and Observability.

---

## 📅 Month 1: Advanced Terraform, Key Vault & K8s Internals
**Objective:** Master Infrastructure as Code (IaC) and secure Kubernetes deployments.

### Week 1: # Terraform Mastery Progress Summary

### Day 1: Terraform Fundamentals (Part 1)
* **Concepts:** Core pillars of Infrastructure as Code (IaC). Mastering **Input Data Modeling** using complex types like `map(object({...}))` and using **Locals** to keep the logic "DRY" (Don't Repeat Yourself).
* **Iteration Engine:** Implementing `for_each` to scale resources dynamically and using the `lookup()` function to handle optional data attributes and avoid runtime errors.
* **Key Takeaway:** Understanding that Terraform is not just a script, but a state-driven engine that requires precise data structures to function at scale.

### Day 2: State Management & Remote State
* **Concepts:** Moving from local state to **Enterprise-grade Remote Backends** (Azure Storage Account) to enable team collaboration and **State Locking**.
* **Data Chaining:** Mastering the `terraform_remote_state` data source to fetch information from one layer (e.g., Resource Group IDs) and consume it in another layer (Networking) without hardcoding values.
* **Deep Dive:** Understanding the state lifecycle—how Terraform tracks real-world infrastructure vs. configuration files to maintain the "Source of Truth."

### Day 3: Introduction to Terraform Modules
* **Concepts:** Moving from "Scripting" to "Engineering." Understanding a Module as a **Container** that encapsulates multiple resources into a single logical unit.
* **Module Anatomy:** Establishing the **Standard Module Structure**—the role of `main.tf` (Implementation), `variables.tf` (The Interface), and `outputs.tf` (The Data Contract).
* **Sourcing:** Learning how to call local modules via relative paths and exploring the **Terraform Registry** to consume official, verified infrastructure patterns.

### Day 4: Advanced Modules Lab (The Refactoring Challenge)
* **Hands-on Lab:** Refactoring individual resource folders (`00_rg`, `01_vnet`, `03_vm`) into a library of **Reusable Child Modules**.
* **Output Chaining:** Implementing a "Producer-Consumer" pattern where the Networking module outputs a Subnet ID and the VM module consumes it as a direct input, replacing static data sources.
* **Environmental Scaling:** Implementing a **Root Module** orchestrator to deploy across multiple environments (Dev, UAT, Prod) using the same code base with different parameter values (e.g., SKU sizes and CIDR blocks).

---

### Week 2: # Advanced Terraform Engineering & Enterprise Operations

### Day 5: Dynamic Logic, Provisioners & Environment Isolation
* **Concepts:** Moving from static scripts to "Intelligent" and "Bootstrapped" infrastructure.
* **Topic 1: Conditional Infrastructure:** * Mastering the Ternary Operator: `count = var.create_vm ? 1 : 0`.
    * **The Lead's Insight:** Understanding why `for_each` is the professional standard for scaling to prevent "Index Shifting" errors.
* **Topic 2: Terraform Import:** * **terraform import:** Learn how to import existing resource using `terraform import` command
* **Topic 3: Dynamic Blocks:** * Implementing `dynamic` blocks to iterate over nested configurations (e.g., generating multiple `security_rule` blocks within a single NSG resource).
    
* **Topic 4: Terraform Provisioners (The Last Mile):** * **local-exec:** Running scripts on the local execution machine.
    * **remote-exec & file:** Automating VM bootstrapping (e.g., installing Nginx or Docker) immediately after the resource is created.
* **Topic 5: Environment Isolation (Workspaces):** * Managing state isolation using `terraform workspace new`, `list`, and `select`.
    * Using `${terraform.workspace}` to dynamically name resources based on the active environment.
    

### Day 6: Post-Apply Operations & CI/CD Pipelines
* **Concepts:** Moving to native cloud bootstrapping and secure, automated deployment workflows.
* **Topic 1: Post-Apply Operations (The "Lead" Way):**
    * **Cloud-Init Mastery:** Implementing `custom_data` in Azure to bootstrap VMs natively during the first boot.
    * **Cloud-init Data Source:** Using `data "cloudinit_config"` to render multi-part MIME configurations, allowing for complex software installation and file placement without SSH access.
* **Topic 2: Automated CI/CD Pipelines with GitHub Actions:**
    * **Azure OIDC Integration:** Setting up **OpenID Connect (OIDC)** between GitHub and Azure to allow GitHub Actions to access Azure resources without storing long-lived Client Secrets (Passwordless Authentication).
    * **Federated Credentials:** Configuring the Azure AD (Entra ID) App Registration to trust your GitHub repository and branch.
* **Topic 3: The Production Workflow:**
    * **Automated Logic:** Configuring GitHub Actions to trigger `terraform plan` on Pull Requests and `terraform apply` on merges to the `main` branch.
    * **State Management in CI:** Handling remote backend locking and ensuring concurrent pipeline runs don't corrupt the state file.
    

### Day 7: Enterprise Scaling with Terraform Cloud
* **Concepts:** Moving the "State" and "Execution" to a centralized managed platform.
* **Topic 1: Terraform Cloud (TFC) Fundamentals:** * Setting up Organizations and Workspaces in TFC.
    * **Remote Execution:** Moving from "Laptop-driven" Terraform to "Cloud-driven" execution.
* **Topic 2: State Hosting & Governance:** * Managing Remote State in TFC and understanding **State Versioning** and **History**.
    * **VCS Integration:** Connecting TFC directly to GitHub/GitLab for automated runs.
* **Topic 3: Team Collaboration:** * Implementing **Private Module Registries** (sharing modules across the whole company).
    * Understanding **Policy as Code** (Sentinal/OPA) to block non-compliant code before it is deployed.

---

### **Assignment: The Graduation Project (Day 5, 6 & 7)**

**Objective:** Deploy a Production-Ready environment using Logic, Security, and Cloud Execution.

**The Tasks:**
1. **The Logic:** Create a **Workspace** named `prod`. Use a **Conditional** to only deploy a "Log Analytics Workspace" in `prod`. Use a **Dynamic Block** to open a list of 5 ports in your NSG.
2. **The Last Mile:** Use a **Provisioner** to install Nginx and write a custom "Hello World" HTML file to the VM.
3. **The Refactor:** Use a **`moved` block** to move your VM resource into a Child Module. Prove there is 0 downtime.
4. **The Lock:** Fetch the VM password from **Azure Key Vault** and apply a `prevent_destroy` hook to the Resource Group.
5. **The Cloud:** Migrate your local state to **Terraform Cloud** and trigger a successful run via a GitHub commit.