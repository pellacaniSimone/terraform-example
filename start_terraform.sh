#!/usr/bin/bash


rm -rf terraform.tfstate .terraform.lock.hcl .terraform || echo
terraform init && terraform plan && terraform apply
