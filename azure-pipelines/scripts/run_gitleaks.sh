#!/usr/bin/env bash
set -euo pipefail

echo "Running Gitleaks scan on repository..."
gitleaks detect --source . --no-banner
