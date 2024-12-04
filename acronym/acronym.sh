#!/usr/bin/env bash

IFS=' -' read -ra parts <<< "${1//[_*]/}"

#local acronym
for part in "${parts[@]}"; do
	acronym+=${part:0:1}
done

echo "${acronym^^}"
