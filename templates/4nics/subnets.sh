#!/usr/bin/env bash
source ./config.sh
set -x

az network vnet subnet create -g ${rg} --vnet-name ${rg}-vnet -n mgmt --address-prefix ${mgmt_net} --nsg ${rg}-nsg -o table
az network vnet subnet create -g ${rg} --vnet-name ${rg}-vnet -n external --address-prefix ${ext_net} --nsg ${rg}-nsg -o table
az network vnet subnet create -g ${rg} --vnet-name ${rg}-vnet -n internal --address-prefix ${int_net} --nsg ${rg}-nsg -o table
az network vnet subnet create -g ${rg} --vnet-name ${rg}-vnet -n ha --address-prefix ${ha_net} --nsg ${rg}-nsg -o table
