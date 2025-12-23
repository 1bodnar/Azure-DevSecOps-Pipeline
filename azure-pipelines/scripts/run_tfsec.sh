#!/usr/bin/env bash
set -euo pipefail

: "${TF_WORKING_DIR:?TF_WORKING_DIR must be set}"

cd "$TF_WORKING_DIR"

echo "Running tfsec on Terraform directory: $TF_WORKING_DIR"

# Basic Azure-focused scan
# tfsec automatically detects azurerm resources and runs AZU* checks,
# but we can tune severity/exit behavior here.
tfsec \
  --no-color \
  --soft-fail=false \
  --minimum-severity=CRITICAL
