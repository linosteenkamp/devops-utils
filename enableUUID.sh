#!/bin/bash

input=${1}

[ -z "${input}" ] && printf "provide virtual machine name or name pattern to match \r\n" && exit 1

read -s -p "VSphere Password: " PASSWORD
echo
export GOVC_PASSWORD="${PASSWORD}"

vms=$(govc ls vm | grep $input)

for x in $vms; do 
  echo "Modifying $x"
  $(govc vm.change -e="disk.enableUUID=1" -vm="$x") 
  $(govc vm.power -r "$x" >/dev/null 2>&1) 
done 
