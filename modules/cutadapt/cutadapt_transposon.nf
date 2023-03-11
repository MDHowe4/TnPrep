
process CUTADAPT_TN {
  tag "CUTADAPT Tn trimming on $reads_ch"
  publishDir "${params.output}/trimmed/CA_tranposon_trimmed", mode: 'copy', pattern: "*.txt"


  input:
  path reads_ch

  output:
  path "trim_${reads_ch}"
  path "TNtrimmed${reads_ch.getBaseName(2)}_stats_transposontrimming.txt" , emit: cutadapt_TN_logs
 // path "${reads_ch}_stats_transposontrimming.txt"

  script:
  """
  cutadapt \
    -g CCGGGGACTTATCAGCCAACCTGT \
    --discard-untrimmed \
    --cores=4 \
    -o trim_${reads_ch} \
    ${reads_ch} \
    > TNtrimmed${reads_ch.getBaseName(2)}_stats_transposontrimming.txt
  """
}

process CUTADAPT_ADAPTER {
  tag "CUTADAPT adapter trimming on $cutadapt_tn"
  publishDir "${params.output}/trimmed/CA_adapter_trimmed", mode: 'copy', pattern: "*.txt"


  input:
  path cutadapt_tn
  path cutadapt_txt

  output:
  path "final${cutadapt_tn}"
  path "adapter${cutadapt_tn.getBaseName(2)}_stats_adaptertrimming.txt", emit: cutadapter_logs

  script:
  """
  cutadapt \
    -a GATCCCACTAGTGTCGACACCAGTCTC \
    --minimum-length=18 \
    --cores=4 \
    -o final${cutadapt_tn} \
    ${cutadapt_tn} \
    > adapter${cutadapt_tn.getBaseName(2)}_stats_adaptertrimming.txt

  """
}

