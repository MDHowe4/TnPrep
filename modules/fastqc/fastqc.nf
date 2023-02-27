
process FASTQC {
  tag "FASTQC on $reads_ch"
  conda 'bioconda::fastqc=0.11.9'
  publishDir "${params.output}/fastqc", mode: 'copy'

  input:
  path reads_ch

  output:
  path "fastqc_${reads_ch}_logs" 

  script:
  """
  fastqc.sh "$reads_ch"
  """
}
