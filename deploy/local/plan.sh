#!/bin/bash
if [ $# -eq 0 ]; then
  ENV_DIR="dev"
else
  ENV_DIR="$1"
fi
export $ENV_DIR
echo "Start preparing plan for $ENV_DIR environment"

source deploy/local/export-variables.sh
sleep 5

source deploy/local/terraform/terraform-init.sh

source deploy/local/terraform/terraform-validate.sh

source deploy/local/terraform/terraform-plan.sh
