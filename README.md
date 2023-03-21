# TnPrep
## Description
TnPrep is a Tn-seq Nextflow pipeline for QC, mapping and counting of Himar1 mariner transposon insertion read sequencing data to positions within a supplied bacterial reference genome following the schema outlined in .

The output of this pipeline is a `.wig` file containing insertion counts mapped to all TA sites found within the reference genome and QC information in the form of a MultiQC report. The `.wig` file is compatible with TRANSIT or other tools for downstream data analysis.


## Requirements
**1.** A POSIX compatible system (Linux, OS X, WSL (tested on Ubuntu), etc)

**2.** [`Java 11 or later (up to 18)`](https://www.oracle.com/java/technologies/downloads/#jdk17-linux)

**3.** Install [`Nextflow`](https://www.nextflow.io/docs/latest/getstarted.html#installation) ( `>=22.10.7` ). Older versions may work, but are untested. ( [`this tutorial`](https://nextflow.io/blog/2021/setup-nextflow-on-windows.html) can be helpful to setup an environment to run Nextflow in Windows, just skip dev tool installations )

**4.** Install any of [`Docker`](https://docs.docker.com/engine/install/), [`Podman`](https://podman.io/getting-started/installation), or [`Singularity`](https://docs.sylabs.io/guides/3.0/user-guide/) ( tutorial can be found [`here`](https://singularity-tutorial.github.io/01-installation/) )

**5.** Tn-seq FASTA files in gzip-compressed `.fa.gz` format


## Running TnPrep

TnPrep can be automatically fetched or updated directly using the following command
```
nextflow pull MDHowe4/TnPrep
```
The pipeline can also be fetched by running directly on a file directory containing Tn-seq data in a compatible format. Running TnPrep requires supply of an input and output directory, as well as a reference genome in FASTA format
```
nextflow run MDHowe4/TnPrep -profile docker/singularity/podman \
                            --input </path/to/input_file_directory> \
                            --genome </path/to/fasta_DNA_reference> \
                            --output </path/to/output_directory>
```

**Parameters:**

`--input`: Path to the input files directory

`--genome`: Absolute path to the DNA reference file in Fasta format

`--output`: Path to the output file directory

All files in the input file directory should be in the same file format for compatibility with this pipeline. 



## Software
Program | Version
:---: | :---:
fastqc | 0.11.9
cutadapt | 4.1
bowtie2 | 2.5.1
multiqc | 1.14
biopython | 1.81
