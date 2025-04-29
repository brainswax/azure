#!/usr/bin/env bash
source ./config.sh
set -x

az network nic create -g ${rg} -n ${vmname}-mgmt-nic --vnet-name ${rg}-vnet --subnet mgmt --accelerated-networking -l ${region} --public-ip-address ${vmname}-ip -o table
az network nic create -g ${rg} -n ${vmname}-external-nic --vnet-name ${rg}-vnet --subnet external --accelerated-networking -l ${region} -o table
az network nic create -g ${rg} -n ${vmname}-internal-nic --vnet-name ${rg}-vnet --subnet internal --accelerated-networking -l ${region} -o table
az network nic create -g ${rg} -n ${vmname}-ha-nic --vnet-name ${rg}-vnet --subnet ha --accelerated-networking -l ${region} -o table

