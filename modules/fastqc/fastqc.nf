
process FASTQC {
  tag "FASTQC on $reads_ch"
  debug true
  publishDir 'outdir/fastqc_out', mode: 'copy'

  input:
  path reads_ch

  output:
  path "fastqc_${reads_ch}_logs" 

  script:
  """
  fastqc.sh "$reads_ch"
  """
}
