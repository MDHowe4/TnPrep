
process INDEX {
  tag "Creating index for ${params.genome}"
  publishDir "${params.output}/bowtie2/index", mode: 'copy'


  input:
  path genome

  output:
  path 'indices*'

  script:
  """
  bowtie2-build --quiet -f ${params.genome} indices
  
  """
}

process ALIGN {
  tag "Aligning reads for $cutadapt_final"
  publishDir "${params.output}/bowtie2/SAM_files", mode: 'copy'


  input:
  path index
  path cutadapt_final
  path cutadapt_txt

  output:
  path "${cutadapt_final.getBaseName(2)}.sam"
  path "${cutadapt_final.getBaseName(2)}_alignment_summary.log" , emit: alignment_logs
  script:
  """

bowtie2 \
    -q \
    -sam \
    -x indices $cutadapt_final \
    -S "${cutadapt_final.getBaseName(2)}.sam" \
    2> "${cutadapt_final.getBaseName(2)}_alignment_summary.log"

  
  """
}