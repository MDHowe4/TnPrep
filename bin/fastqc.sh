#!/usr/bin/env bash
reads="$1"

mkdir fastqc_${reads}_logs
fastqc -o fastqc_${reads}_logs -q ${reads}