#####################################################################
#                      lxc setup
#####################################################################
resource "proxmox_lxc" "basic" {

  target_node         = var.pve_target_host      
  hostname            = var.hostname             
  description         = "terraform provisioned on ${timestamp()}"    
  ostemplate          = var.target_os_image
  ostype              = var.type_os_image
  unprivileged        = true
  memory              = 1024
  swap                = 50
  vmid                = null
  start               = true # on creation
  onboot              = false # start

  ssh_public_keys = var.key_list

  rootfs {
    storage = "drive"
    size    = "8G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr0"
    ip     = "dhcp"
    ip6     = "dhcp"
  }

  features {
    fuse    = true
    nesting = true
    mount   = "nfs;cifs"
  }
}


#####################################################################
#                      instal SSH (non present on alpine)
#####################################################################

data "external" "get_vmid" {
  depends_on = [proxmox_lxc.basic] # Aspetta che il container sia creato
  program = [
    "bash", 
    "-c", 
    "VMID=$(ssh -o StrictHostKeyChecking=no root@${var.endpoint} pct list | grep '${var.hostname}' | cut -f1 -d' ' | tr -d '\\n')&&  echo -n \"{\\\"vmid\\\": \\\"$VMID\\\"}\""
  ]
}

resource "null_resource" "wait1_openssh" {
  depends_on = [data.external.get_vmid]  
  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "null_resource" "add_openssh" {
  depends_on = [null_resource.wait1_openssh]  
  provisioner "local-exec" {
    command = "ssh -o StrictHostKeyChecking=no root@${var.endpoint} pct exec ${data.external.get_vmid.result.vmid} apk add openssh"
  }
}

resource "null_resource" "wait2_openssh" {
  depends_on = [null_resource.add_openssh] 
  provisioner "local-exec" {
    command = "sleep 5"
  }
}

resource "null_resource" "set_openssh" {
  depends_on = [null_resource.wait2_openssh] 
  provisioner "local-exec" {
    command = "ssh -o StrictHostKeyChecking=no root@${var.endpoint} pct exec ${data.external.get_vmid.result.vmid} service sshd start"
  }
}

resource "null_resource" "move_files" {
  depends_on = [null_resource.set_openssh] 
  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no  ./file_post_install/*     root@${var.hostname}.local.lan:/root/"
  }
}





#####################################################################
#                      post install
#####################################################################
resource "null_resource" "get_vmid" {

  depends_on = [null_resource.move_files]  # Aspetta che l'installazione e l'avvio di SSH siano completati

  provisioner "remote-exec" {
    inline = var.procedura

    connection {
      agent       = false # prevent Error connecting to SSH_AUTH_SOCK
      type        = "ssh"
      user        = "root"
      private_key = file("~/.ssh/id_rsa")
      host        = "${var.hostname}.local.lan"
    }
  }
}







