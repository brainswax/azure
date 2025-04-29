#!/usr/bin/env bash
set -x
source ./config.sh
az group create -n ${rg} -l ${region} -o table
az network vnet create -n ${rg}-vnet -g ${rg} -l ${region} -o table
az network nsg create -n ${rg}-nsg -g ${rg} -o table 
