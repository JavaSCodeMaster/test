#!/bin/zsh
terraform init -backend=false -backend-config="env/${ENV_DIR}/config.azurem.tfbackend"
