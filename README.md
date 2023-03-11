# TnPrep
## Description
Tn-seq Nextflow pipeline for QC, mapping and counting of Himar1 mariner transposon insertion read sequencing data to positions within a supplied bacterial reference genome.

The output of this pipeline is a wig file containing insertion counts mapped to all TA sites found within the reference genome. This file is compatible with TRANSIT or other tools for downstream data analysis.



## Usage:
**2-step guide for running the pipeline:**

**1.** Clone this repository into the directory where you would like the Tn-seq processing to take place

```shell
git clone https://github.com/MDHowe4/Himar1-TnSeq-Pipeline.git
```

This will require a github account to be able to clone repositories onto MSI. 
You must also create a personal access token on Github through Settings>Developer Settings>Personal access 
tokens>Fine-grained personal access tokens. This must be supplied when prompted the first time you download the scripts.
The repository can alternatively be downloaded directly and the scripts can be manually copied into your analysis directory bypassing needing to git clone.

**2.** Run the pipeline within the directory you cloned the repository into using the following command:

```
qsub Tnseq_Analysis_Script.sh -i [/path/to/Inputfiledirectory] -d [/path/to/FastaDNAreference]
```

**Parameters:**

`-i`: Path to the input files directory

`-d`: Absolute path to the DNA reference file in Fasta format

All files in the input file directory should be either zipped or unzipped and in the same file format for compatibility with this pipeline. 
## Output
Following completion of the pipeline there will be a folder called SAMfiles. Within this directory all .sam (sequence alignments)  and .wig (TA insertion counts) final output files can be found.


## Software
Program | Version
:---: | :---:
fastqc | 0.11.9
cutadapt | 4.1
bowtie2 | 2.5.1
multiqc | 1.14
biopython | 1.81
