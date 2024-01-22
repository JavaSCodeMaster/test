#!/bin/zsh
if [ $# -eq 0 ]; then
  ENV_DIR="dev"
else
  ENV_DIR="$1"
fi
export $ENV_DIR

echo "Start apply plan for $ENV_DIR environment"

terraform apply \
    -auto-approve \
    -state-out="env/${ENV_DIR}/terraform.tfstate" \
    -state="env/${ENV_DIR}/terraform.tfstate" \
    "env/${ENV_DIR}/terraform.plan.bin"
