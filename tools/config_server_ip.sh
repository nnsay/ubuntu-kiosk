#!/usr/bin/env bash

##################################################################
# All script base on ubuntu 18.04.3 chinese minimal installation.
# default account
#  user name: ngiq
#  password:  123456
##################################################################

set -e

# check assign ip
ASSIGNED_IP=$1
if [[ -z "$ASSIGNED_IP" ]]; then
  echo "ASSIGNED_IP is required"
  exit 1
fi

# generate ngbox.json for navigator access the box
NGBOX_CONFIG_PATH=~/.config/ngiq-app-desktop/ng_preferences
NGBOX_CONFIG_FILE=${NGBOX_CONFIG_PATH}/ngbox.json
mkdir -p ${NGBOX_CONFIG_PATH}
cat > "${NGBOX_CONFIG_FILE}" << EOF
{
 "assignedIp": "${ASSIGNED_IP}"
}
EOF

echo "Report:"
echo "ASSIGNED_IP: $ASSIGNED_IP"
