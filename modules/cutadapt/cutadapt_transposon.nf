
process CUTADAPT_TN {
  tag "CUTADAPT Tn trimming on $reads_ch"

  publishDir "${params.output}/trimmed/CA_tranposon_trimmed", mode: 'copy'


  input:
  path reads_ch

  output:
  path "tntrimmed_${reads_ch}"
  path "${reads_ch.baseName}_stats_transposontrimming.txt"
 // path "${reads_ch}_stats_transposontrimming.txt"

  script:
  """
  cutadapt \
    -g CCGGGGACTTATCAGCCAACCTGT \
    --discard-untrimmed \
    --cores=10 \
    -o tntrimmed_${reads_ch} \
    ${reads_ch} \
    > ${reads_ch.baseName}_stats_transposontrimming.txt
  """
}

process CUTADAPT_ADAPTER {
  tag "CUTADAPT adapter trimming on $cutadapt_tn"
 
  publishDir "${params.output}/trimmed/CA_adapter_trimmed", mode: 'copy'


  input:
  path cutadapt_tn
  path cutadapt_txt

  output:
  path "final_${cutadapt_tn}"
  path "${cutadapt_tn.baseName}_stats_adaptertrimming.txt"

  script:
  """
  cutadapt_adapter.sh "$cutadapt_tn"
  """
}

