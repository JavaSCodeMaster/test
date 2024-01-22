#!/bin/bash
if [ $# -eq 0 ]; then
  ENV_DIR="dev"
else
  ENV_DIR="$1"
fi
export $ENV_DIR

source ./deploy/local/export-variables.sh
sleep 5

source ./deploy/local/terraform/terraform-validate.sh
