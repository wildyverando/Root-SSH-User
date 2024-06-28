#!/bin/bash

if ! [[ $(whoami) == 'root' ]]; then
  echo "Run as sudo and try again"
  exit
fi

default_sftp_exec() {
  echo $(cat /etc/ssh/sshd_config | grep -w Subsystem | grep -w sftp | awk '{print $3}')
}

gen_sshd_template() {
  local sftp_path=$(default_sftp_exec)
  echo -e $"Port 22\nListenAddress 0.0.0.0\nListenAddress ::\nUsePAM yes\nUseDNS no\nTCPKeepAlive yes\nX11Forwarding yes\nPermitRootLogin yes\nPrintMotd no\nChallengeResponseAuthentication no\nAcceptEnv LANG LC_*
Subsystem sftp ${sftp_path}"
}

# >> Random pass
rand_pwd=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 12)

# >> Reconfigure sshd
rm -rf /etc/ssh/*
gen_sshd_template > /etc/ssh/sshd_config
ssh-keygen -A

# >> Execute change pwd
passwd root > /dev/null 2>&1 << EOF
$rand_pwd
$rand_pwd
EOF

# >> Done
echo "Save the credential.
======================================
User: root
Password: $rand_pwd
Port: 22
======================================
"
sleep 10
reboot
