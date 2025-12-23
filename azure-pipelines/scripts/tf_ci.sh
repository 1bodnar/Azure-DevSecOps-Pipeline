#!/usr/bin/env bash
set -euo pipefail

: "${TF_WORKING_DIR:?TF_WORKING_DIR must be set}"
: "${TF_VAR_FILE:?TF_VAR_FILE must be set}"
: "${TF_BACKEND_RG:?TF_BACKEND_RG must be set}"
: "${TF_BACKEND_SA:?TF_BACKEND_SA must be set}"
: "${TF_BACKEND_CONTAINER:?TF_BACKEND_CONTAINER must be set}"
: "${TF_BACKEND_KEY:?TF_BACKEND_KEY must be set}"

cd "$TF_WORKING_DIR"

echo "==> terraform init (CI)"
terraform init \
  -backend-config="resource_group_name=${TF_BACKEND_RG}" \
  -backend-config="storage_account_name=${TF_BACKEND_SA}" \
  -backend-config="container_name=${TF_BACKEND_CONTAINER}" \
  -backend-config="key=${TF_BACKEND_KEY}"

echo "==> terraform fmt & validate (CI)"
terraform fmt -recursive
terraform validate

echo "==> terraform plan (CI, no apply)"
terraform plan -var-file="${TF_VAR_FILE}" -out=tfplan
