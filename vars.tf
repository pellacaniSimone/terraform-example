#####################################################################
#                      input var
#####################################################################

# Definiamo la variabile per la password
variable "proxmox_password_input" {
  description = "Inserisci la password per l'account root@pam su Proxmox"
  type        = string
  sensitive   = true
}

#####################################################################
#                      Proxy tfvars
#####################################################################

variable "endpoint" {
    type=string
  }

variable "pve_target_host" {
    type=string
  }

variable "username" {
    type=string
  }


variable "hostname" {
    type=string
  }

variable "target_os_image" {
    type=string
  }

variable "type_os_image" {
    type=string
  }

variable "key_list" {
    type=string
  }

variable "procedura" {
    type=list
  }