#!/usr/bin/bash


rm -rf terraform.tfstate .terraform.lock.hcl .terraform || echo
terraform init && terraform plan && terraform apply






# Guide

# https://www.alexdarbyshire.com/2024/02/automating-vm-creation-on-proxmox-terraform-bpg/
# https://registry.terraform.io/providers/Telmate/proxmox/2.9.11/docs/resources/lxc
# https://pve.proxmox.com/pve-docs/pve-admin-guide.html#pct_startup_and_shutdown
# https://www.slingacademy.com/article/terraform-how-to-execute-shell-bash-scripts/
#  https://github.com/trfore/terraform-telmate-proxmox/blob/main/README.md
# https://tcude.net/using-terraform-with-proxmox/
