#  Azure DevSecOps CI/CD Pipeline using TFLINT, GitLeaks & TFSEC  

## 1 Trigger Conditions

Pipeline runs only when relevant Terraform configuration changes. (Automatic run or PR)

## 2 Execution Pool

Uses **self‑hosted agent → ado‑vm‑01**

```
pool:
  name: 'ado-pool'
  demands:
    - Agent.Name -equals ado-vm-01
```

## 3️⃣ Variables (TF Backend + Env Config)

```
TF_WORKING_DIR      = workload
TF_VAR_FILE         = env/test.tfvars
TF_BACKEND_RG       = rg-tfstate-ladislav-test-northeu
TF_BACKEND_SA       = stgtfladislavtestneu01
TF_BACKEND_CONTAINER= tfstate
TF_BACKEND_KEY      = test.tfstate
```

## 4️⃣ CI Stage — Validate, Scan, Plan

### Tools executed:
- TFLint - checks Terraform code quality
- TFsec - security misconfiguration audit
- Gitleaks - scans repo for hardcoded secrets
- Terraform fmt + validate + plan (OIDC auth)

Terraform plan summary is formatted using diff color & uploaded to pipeline.

Artifact stored:
```
tfplan-test
```


## 5️⃣ CD Stage — Manual Approval + Apply

CD runs only when:
✔ main branch  
✔ CI succeeded  
❌ not a PR  

Manual gate:
```
ManualValidation@0
timeout=24h
```

Then Terraform executes approved tfplan via:
```
Download plan → terraform apply
OIDC passwordless auth
```

---

## CI/CD Flow Overview

```
Push or PR
   ↓
CI Stage ── Lint + Scan + Plan
   ↓
Approval Required ✔
   ↓
CD Stage ── Apply Terraform
   ↓
Infrastructure Updated
```

---

This pipeline enforces secure Terraform delivery using gated approvals, OIDC authentication, and automated lint/security validation.
