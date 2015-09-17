#!/bin/bash

# an ugly way of establishing vpn connection to cmu
read -p "andrew id: " ANDREWID 1>&2 
stty -echo
read -p "pass: " PASS 1>&2 ; echo 
stty echo

PASS=$(echo "${PASS}" | sed 's/[][{}$\]/\\\0/g')
EXE="cmu-vpn.sh"
touch "${EXE}"
chmod +x "${EXE}"
cat<<EOF > "${EXE}"
#!/usr/bin/expect -f
set timeout -1
spawn  sudo openconnect --script /etc/vpnc/vpnc-script vpn.cmu.edu --authgroup "General Use Campus VPN" -u ${ANDREWID}
set send_human {.1 .3 1 .05 2}
# for whatever reason might have to send it twice
expect -re "Password:"
send -h "${PASS}\n"
expect -re "Username:"
send "${ANDREWID}\n"
expect -re "Password:"
send -h "${PASS}\n"
expect "Established DTLS connection"
if {[fork]!=0} exit
   disconnect
EOF


echo "wrote to ${EXE}"
