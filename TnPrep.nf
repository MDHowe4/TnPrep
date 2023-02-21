params.reads = "$baseDir/Test_files/*.gz"
params.genome_file = "$baseDir/Genome_file/H37Rv_Reference_Genome_NC_000962.3.fasta"

log.info """\
                    T N P R E P   
         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         reference    : ${params.genome_file}
         reads        : ${params.reads}
         outdir       : ${params.outdir}
         """
         .stripIndent()

// import modules
include { FASTQC } from './modules/fastqc/fastqc.nf'
include { CUTADAPT_TN } from './modules/cutadapt/cutadapt_transposon.nf'
include { CUTADAPT_ADAPTER } from './modules/cutadapt/cutadapt_transposon.nf'
include { INDEX } from './modules/bowtie2/bowtie2.nf'
include { ALIGN } from './modules/bowtie2/bowtie2.nf'
include { PYCOUNT } from './modules/countPy/countPy.nf'

workflow {
  reads_ch = channel.fromPath( params.reads, checkIfExists: true )
  //reads_ch.view()
  FASTQC( reads_ch )
  CUTADAPT_TN( reads_ch )
  CUTADAPT_ADAPTER( CUTADAPT_TN.out )
  INDEX(params.genome_file)
  ALIGN(INDEX.out, CUTADAPT_ADAPTER.out)
  PYCOUNT(ALIGN.out,params.genome_file)
}

workflow.onComplete {
summary = """
=======================================================================================
Workflow execution summary
=======================================================================================
Duration    : ${workflow.duration}
Success     : ${workflow.success}
workDir     : ${workflow.workDir}
Exit status : ${workflow.exitStatus}
outDir      : ${params.outDir}
=======================================================================================
  """
println summary

}

