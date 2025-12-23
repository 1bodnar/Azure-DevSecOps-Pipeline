#!/usr/bin/env bash
set -euo pipefail

TFLINT_VERSION="0.55.0"
GITLEAKS_VERSION="8.18.4"
TFSEC_VERSION="1.28.4"   # pinned version

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"

########################################
# TFLint
########################################
echo "Installing TFLint v${TFLINT_VERSION}..."
curl -fsSL \
  "https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip" \
  -o tflint_linux_amd64.zip

unzip -o tflint_linux_amd64.zip
rm -f tflint_linux_amd64.zip

mv tflint "${BIN_DIR}/tflint"
chmod +x "${BIN_DIR}/tflint"

########################################
# Gitleaks
########################################
echo "Installing Gitleaks v${GITLEAKS_VERSION}..."
curl -fsSL \
  "https://github.com/gitleaks/gitleaks/releases/download/v${GITLEAKS_VERSION}/gitleaks_${GITLEAKS_VERSION}_linux_x64.tar.gz" \
  -o gitleaks.tar.gz

tar -xzf gitleaks.tar.gz gitleaks
rm -f gitleaks.tar.gz

mv gitleaks "${BIN_DIR}/gitleaks"
chmod +x "${BIN_DIR}/gitleaks"

########################################
# tfsec
########################################
echo "Installing tfsec v${TFSEC_VERSION}..."
curl -fsSL \
  "https://github.com/aquasecurity/tfsec/releases/download/v${TFSEC_VERSION}/tfsec-linux-amd64" \
  -o "${BIN_DIR}/tfsec"

chmod +x "${BIN_DIR}/tfsec"

########################################
# Make available for this & next steps
########################################
export PATH="${BIN_DIR}:$PATH"
echo "##vso[task.prependpath]${BIN_DIR}"

echo "TFLint version:"
tflint --version || true

echo "Gitleaks version:"
gitleaks version || true

echo "tfsec version:"
tfsec --version || true
