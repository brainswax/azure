#!/usr/bin/env bash
source ./config.sh
set -x

az network public-ip create -n ${vmname}-ip -g ${rg} -l ${region} -o table
