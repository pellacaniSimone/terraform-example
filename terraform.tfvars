#####################################################################
#                      setup target
#####################################################################

# ip4 target con proxmox server
endpoint = "172.16.0.70"

# hostname target con proxmox server
pve_target_host = "pvenas07"


# login username target @ domain
username = "root@pam"

# nome VM/container
hostname = "alpineJupyterLab"


# nome VM/container
target_os_image = "template:vztmpl/alpine-3.20-default_20240908_amd64.tar.xz"
type_os_image = "alpine"

# accessi ssh pubkey
key_list = <<-EOT
    ssh-rsa AAAA1yc2EAAAADAQABAAABgQXxsFIkCCx9c9x4OO6zvnnkOb6A48qBqNSfARLK6WvK9FobyzDHKRVfv/X8Nph7giSce17CKgqFvBVn4zkPnfPmUL/6WAMag+MRSyaDzYWBVF6VZOyw2eKSCdKnwf4DvxfULiqvNVSm46Q9/Lxq3fcdC7Mjvu7gcH1OG28mGAngWNqG97XH7sXKz53SC/Vbyay1npMUVsX8wOXnWs5494KbD+TKmyAg7UznRId/d1WTxiTEu2uKIKmpxwfIc4i0x+tnqnTMXice2KVPURp0OBXXB0ATgdrvGH58zQG9x9Q1ZCKA57kfv2AKI87r30sx1ZnkLVrVObCb4fz7C2ScUwa8l9RW4q7HuxbV8dpAepSx+3jxDjJKxdbDcsqUIzFBW3dIZkD3EQvoqPLpDJCZFHx/QxzdSSELg2R5Xp6MOa9gledhfoNTxNxxSEvtDYt/AE7a3YRsSiTvQTSglh/AUfB10Klj0= unigithub@xps9510
  EOT

# install app procedure
procedura= [
      "apk update",
      "apk add openssh",
      "rc-update add sshd",
      "service sshd start",
      "apk add python3 curl bash git wget libffi-dev ncurses-dev openssl-dev readline-dev tk-dev xz-dev zlib-dev gcc",
      #"apk add py3-pip",
      "apk add gcc python3-dev musl-dev linux-headers R",
      "curl https://pyenv.run | bash",
      "python -m venv .venv",
      "source .venv/bin/activate",
      "pip install pip jupyterlab",
      "mv /root/jupyterlab_open-rc /etc/init.d/jupyterlab",
      "chmod +x /etc/init.d/jupyterlab",
      "chmod +x /root/start_server.sh",
      "rc-update add jupyterlab default",
      "service jupyterlab start",
    ]

