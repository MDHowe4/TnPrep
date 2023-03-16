#!/usr/bin/env python

from Bio import SeqIO
import sys

# Declare Nextflow input variables using the sys package.
ref_genome_bowtie_index = sys.argv[1]  # Bowtie index name
ref_genome_fasta = sys.argv[2] # Reference genome FASTA file

# Function that creates a list of TA sites based upon the reference genome FASTA file supplied

def create_TA_sites(fasta_file):

    TA_sites = []
    count = 0
    for record in SeqIO.parse(fasta_file, "fasta"):
        for i in record.seq:
            if i == "T" or i == "t":
                T_found = True
                T_pos = count
            elif i == "A" or i == "a":
                if T_found == True:
                    TA_sites.append(T_pos)
                    T_found = False
            else:
                T_found = False
            count += 1
    return TA_sites


def count(SAM_file):
    # Make dictionary of possible TA sites in reference
    TA_dict = dict.fromkeys(create_TA_sites(ref_genome_fasta), 0)
    # Set filename to Bowtie sam file index name
    fname = SAM_file
    # Reduce output file name length
    save_name = (fname[10:-3] + "wig")
    # Open file with the correct save name for writing and create header name. Write header name to top of .wig file. Create space for writing of counts.
    save_file = open(save_name, "w")
    header = ("#", '\n', "variableStep chrom=" + SAM_file, '\n')
    save_file.write(''.join(map(str, header)))
    newtab = '\t'
    newline = '\n'

    # Read in SAM file and count mapped insertion reads and append to TA site dictionary
    with open(fname) as input:
        next(input)
        next(input)
        next(input)
        for line in input:
            xx = line.split('\t')
            # xx[0] - read name
            # xx[1] - FLAG (orientation)
            # xx[2] - ref genome
            # xx[3] - map position
            # xx[4] - mapping quality
            # xx[5] - CIGAR string
            # xx[6] - reference name of mate/next read
            # xx[7] - position of mate/next read
            # xx[8] - template length
            # xx[9] - sequence
            # xx[10] - q-score
            seq_len = len(xx[9])
            if xx[1] == "16":
                ins_pos_temp = int(xx[3]) + seq_len - 3
            elif xx[1] == "0":
                ins_pos_temp = int(xx[3]) - 1
            else:
                continue
            try:
                TA_dict[ins_pos_temp] += 1
            except KeyError:
                pass
    ordered_keys = sorted(TA_dict)
    ordered_values = []
    # Write TA sites and counts to file and close
    for j in ordered_keys:
        save_file.write(str(j))
        save_file.write(newtab)
        ordered_values.append(TA_dict[j])
        save_file.write(str(TA_dict[j]))
        save_file.write(newline)
    # print("Finished counting " + fname)
    save_file.close()

count(ref_genome_bowtie_index)
# End of count.py script
