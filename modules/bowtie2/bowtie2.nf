
process INDEX {
  tag "Creating index for ${params.genome_file}"
  publishDir 'outdir/bowtie2_out/index', mode: 'copy'
  debug true

  input:
  path genome_file

  output:
  path 'indices*'

  script:
  """
  bowtie2-build --quiet -f ${params.genome_file} indices
  
  """
}

process ALIGN {
  tag "Aligning reads for $cutadapt_final"
  publishDir 'outdir/bowtie2_out/SAM_files', mode: 'copy'
  debug true

  input:
  path index
  path cutadapt_final
  path cutadapt_txt

  output:
  path "${cutadapt_final}_bowtie2.sam"

  script:
  """

bowtie2 \
    -q \
    -sam \
    -x indices $cutadapt_final \
    -S "${cutadapt_final}_bowtie2.sam"
  
  """
}