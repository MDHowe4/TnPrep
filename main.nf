
// default parameters can be found in the nextflow.config file

// import sub-workflows
include { FASTQC } from './modules/fastqc/fastqc.nf'
include { CUTADAPT_TN } from './modules/cutadapt/cutadapt_transposon.nf'
include { CUTADAPT_ADAPTER } from './modules/cutadapt/cutadapt_transposon.nf'
include { INDEX } from './modules/bowtie2/bowtie2.nf'
include { ALIGN } from './modules/bowtie2/bowtie2.nf'
include { PYCOUNT } from './modules/countPy/countPy.nf'

// Function which prints help message text
def helpMessage() {
  log.info"""
  Usage:
 

  Required Arguments:
  Input Data:
  --input       Folder containing single-end FASTQ files ending with .fastq.gz (gunzipped fastq files only)

  Reference Data:
  --genome      Reference genome in FASTA file format to to use for Bowtie2 alignment

  Optional Arguments:
  Output Location:
  --output      Folder for all output files created by TnPrep. Default behaviour creates a folder 'outdir' within the base directory.
  """.stripIndent()
}



workflow {

  // Show help message if the user specifies the --help flag at runtime
  // or if any required params are not provided
  if ( params.help || params.input == false || params.genome == false ){
      helpMessage()
      // Kill all processes
      exit 1
  }
  // Continue workflow and print logfile with directory inputs
  else {
    log.info """ 
                      T N P R E P   
      ================================================
      Reference file         : ${params.genome}
      Reads directory        : ${params.input}
      Output directory       : ${params.output}
      ================================================
      
      """.stripIndent()
  
  }

  
  // Set output file directory to default into the current working directory and 
  // create an outdir folder where all outputs can be found

  if ( params.input ){
    input_files = "${params.input}/*fastq.gz"
    reads_ch = channel.fromPath( input_files, checkIfExists: true )
  }

  //reads_ch.view()
  FASTQC( reads_ch )
  CUTADAPT_TN( reads_ch )
  CUTADAPT_ADAPTER( CUTADAPT_TN.out )
  INDEX( params.genome )
  ALIGN( 
    INDEX.out, 
    CUTADAPT_ADAPTER.out 
  )
  PYCOUNT(
    ALIGN.out,
    params.genome
    )
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
outDir      : ${params.output}
=======================================================================================
  """
println summary

}

