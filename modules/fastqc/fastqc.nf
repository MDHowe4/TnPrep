
process FASTQC {
  tag "FASTQC on $reads_ch"
  publishDir "${params.output}/fastqc", mode: 'copy'

  input:
  path reads_ch

  output:
  path "fastqc_${reads_ch.getBaseName(2)}_logs" , emit: fastqc_logs

  script:
  """
  mkdir fastqc_${reads_ch.getBaseName(2)}_logs
  fastqc -o fastqc_${reads_ch.getBaseName(2)}_logs -q ${reads_ch}
  """
}
