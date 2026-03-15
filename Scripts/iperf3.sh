#!/usr/bin/env bash

CONFIG_PATH=/media/fat/Scripts/.config/mister-iperf3

[ -f "${CONFIG_PATH}/config" ] && source "${CONFIG_PATH}/config"

if [ -z "${IPERF3_SERVER}" ]; then
  read -r -p "Enter the IP address of your iperf3 server: " IPERF3_SERVER
fi
"${CONFIG_PATH}/iperf3" --forceflush --timestamps --client "${IPERF3_SERVER}" | tee -a /tmp/iperf3.log
