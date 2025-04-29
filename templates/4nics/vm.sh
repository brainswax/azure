#!/usr/bin/env bash
source ./config.sh
set -x

az vm create -n ${vmname} -g ${rg} --size ${vmsize} -l ${region} --image ${publisher}:${offer}:${sku}:${version} --nics ${vmname}-external-nic ${vmname}-internal-nic --generate-ssh-keys -o table
