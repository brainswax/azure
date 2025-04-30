#!/usr/bin/env bash

region=eastus2euap
rg=udppersist
vmname=pmember1
vmsize=Standard_DS3_v2
ext_net=10.0.1.0/24
int_net=10.0.2.0/24
ha_net=10.0.3.0/24
mgmt_net=10.0.4.0/24
publisher=MicrosoftCBLMariner
offer=cbl-mariner
sku=cbl-mariner-2-gen2
version=latest

