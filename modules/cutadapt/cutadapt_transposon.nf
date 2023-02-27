
process CUTADAPT_TN {
  tag "CUTADAPT Tn trimming on $reads_ch"
  conda 'bioconda::cutadapt=4.1'
  publishDir "${params.output}/trimmed/CA_tranposon_trimmed", mode: 'copy'


  input:
  path reads_ch

  output:
  path "tntrimmed_${reads_ch}"
  path "${reads_ch}_stats.txt"
 // path "${reads_ch}_stats_transposontrimming.txt"

  script:
  """
  cutadapt_tspn.sh "$reads_ch"
  """
}

process CUTADAPT_ADAPTER {
  tag "CUTADAPT adapter trimming on $cutadapt_tn"
  conda 'bioconda::cutadapt=4.1'
  publishDir "${params.output}/trimmed/CA_adapter_trimmed", mode: 'copy'


  input:
  path cutadapt_tn
  path cutadapt_txt

  output:
  path "final_${cutadapt_tn}"
  path "${cutadapt_tn}_stats_adaptertrimming.txt"

  script:
  """
  cutadapt_adapter.sh "$cutadapt_tn"
  """
}

