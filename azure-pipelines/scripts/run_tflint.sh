#!/usr/bin/env bash
set -euo pipefail

ENVIRONMENT="${1:-shared}"   # default = shared

echo "Running TFLint for environment: $ENVIRONMENT"

# Go to repo root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# Determine path
case "$ENVIRONMENT" in
  shared)
    TARGET_DIR="$REPO_ROOT/shared"
    ;;
  test|prod)
    TARGET_DIR="$REPO_ROOT/workload"
    ;;
  *)
    echo "ERROR: Unknown environment '$ENVIRONMENT'. Use: shared | test | prod"
    exit 1
    ;;
esac

if [ ! -d "$TARGET_DIR" ]; then
  echo "ERROR: Terraform directory not found: $TARGET_DIR"
  exit 1
fi

echo "Using directory: $TARGET_DIR"
cd "$TARGET_DIR"

tflint --init
tflint
