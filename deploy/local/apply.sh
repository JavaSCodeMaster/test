#!/bin/bash
source ./deploy/local/export-variables.sh
sleep 5

source ./deploy/local/terraform/terraform-apply.sh
