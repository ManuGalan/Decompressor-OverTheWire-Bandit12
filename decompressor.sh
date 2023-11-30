#!/bin/bash

function ctrl_c(){
  echo -e "\n\n[!] Saliendo...\n"
  exit 1
}

# Ctrl+C
trap ctrl_c INT
archivo="data.gz"
decompresor_only="$(7z l data.gz | tail -n 3 | head -n 1 | awk 'NF{print $NF}')"

7z x $archivo&>/dev/null

while [ $decompresor_only ]; do
  echo -e "\n[+] Nuevo archivo descomprimido: $decompresor_only"
  7z x $decompresor_only &>/dev/null
  decompresor_only="$(7z l $decompresor_only 2>/dev/null | tail -n 3 | head -n 1 | awk 'NF{print $NF}')"
done
