
process CUTADAPT_TN {
  tag "CUTADAPT Tn trimming on $reads_ch"
  publishDir 'outdir/tntrim_out', mode: 'copy'
  debug true

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
  publishDir 'outdir/adaptertrim_out', mode: 'copy'
  debug true

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

