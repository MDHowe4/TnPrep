process MULTIQC {
  tag "Generating MultiQC report"
  publishDir "${params.output}/multiqc", mode: 'copy'

  input:
  path fasqc_logs
  path cutadapt_TN_logs
  path cutadapter_logs
  path alignment_logs

  output:
  path "multiqc_report.html"

  script:
  """
  multiqc .
  
  """
}