#!/usr/bin/env bash
reads="$1"
cutadapt \
    -g CCGGGGACTTATCAGCCAACCTGT \
    --discard-untrimmed \
    --cores=10 \
    -o tntrimmed_${reads} \
    ${reads} \
    > ${reads}_stats_transposontrimming.txt
