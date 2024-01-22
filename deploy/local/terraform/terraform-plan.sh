#!/bin/bash
terraform plan \
      -var-file="env/${ENV_DIR}/terraform.tfvars" \
      -out="env/${ENV_DIR}/terraform.plan.bin" \
      -state="env/${ENV_DIR}/terraform.tfstate"
