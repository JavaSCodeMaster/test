#!/bin/zsh
terraform destroy \
    -auto-approve \
    -state="env/${ENV_DIR}/terraform.tfstate" \
    -var-file="env/${ENV_DIR}/terraform.tfvars"
