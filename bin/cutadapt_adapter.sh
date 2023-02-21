#!/usr/bin/env bash
reads="$1"
cutadapt \
    -g GATCCCACTAGTGTCGACACCAGTCTC \
    --minimum-length=18 \
    --cores=10 \
    -o final_${reads} \
    ${reads} \
    > ${reads}_stats_adaptertrimming.txt
