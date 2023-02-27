process PYCOUNT {
  tag "Counting Tn reads for $sam_in"
  publishDir "${params.output}/final_count_wigfiles", mode: 'copy'
  debug true

  input:
  path sam_in
  path genome


  output:
  path "*.wig"

  script:
  """
  count.py "$sam_in" "$genome"
  """
}



