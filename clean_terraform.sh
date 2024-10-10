#!/usr/bin/bash


terraform destroy
rm -rf terraform.tfstate .terraform.lock.hcl .terraform || echo