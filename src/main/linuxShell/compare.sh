#!/bin/bash

FOX_LIST=()
NEO_LIST=()
FOX_OUT=diff_fox.txt
NEO_OUT=diff_neo.txt
echo "" > $FOX_OUT
echo "" > $NEO_OUT

find $(pwd)/*/* -type f -name '*.tmp' -delete

ls -1 */*/* | grep "Fox_Distribution" | sort > list_fox.txt
while IFS= read -r LINE || [[ "$LINE" ]]; do
  FOX_LIST+=("$LINE")
done < list_fox.txt

i=0
ls -1 */*/* | grep "Neo_Distribution" | sort > list_neo.txt
while IFS= read -r LINE || [[ "$LINE" ]]; do
  #NEO_LIST+=("$line")

  printf "%s <--> %s\n" "${FOX_LIST[i]}" "${LINE}" >> $FOX_OUT
  printf "%s <--> %s\n" "${FOX_LIST[i]}" "${LINE}" >> $NEO_OUT

  sort "${FOX_LIST[i]}" | uniq > "${FOX_LIST[i]}.tmp"
  sort "${LINE}" | uniq > "${LINE}.tmp"

  comm -23 "${FOX_LIST[i]}.tmp" "${LINE}.tmp" >> $FOX_OUT
  comm -13 "${FOX_LIST[i]}.tmp" "${LINE}.tmp" >> $NEO_OUT

  printf "\n\n" >> $FOX_OUT
  printf "\n\n" >> $NEO_OUT

  ((i=i+1))
done < list_neo.txt
