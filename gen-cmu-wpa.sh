#!/bin/bash
read -p "andrew id: " ANDREWID 1>&2 
stty -echo
read -p "pass: " PASS 1>&2 ; echo 
stty echo

cat<<EOF > cmuwpa
network={
	ssid="CMU-SECURE"
	scan_ssid=1
	key_mgmt=WPA-EAP
	pairwise=CCMP TKIP
	group=CCMP TKIP
	eap=PEAP
	identity="${ANDREWID}"
	password="${PASS}"
	ca_cert="cmu_comodo_cert.pem"
	phase1="peapver=0"
	phase2="MSCHAPV2"
}
EOF
