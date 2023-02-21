process PYCOUNT {
  tag "Counting Tn reads for $sam_in"
  publishDir 'outdir/counts', mode: 'copy'
  debug true

  input:
  path sam_in
  path genome_file


  output:
  path "*.wig"

  script:
  """
  count.py "$sam_in" "$genome_file"
  """
}



