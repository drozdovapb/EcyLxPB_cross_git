## Fig 1A: map


## Fig 1B: phylogenetic tree

### Assemble *E. cyaneus* mitochondrial genome

```
#pwd
#/media/main/sandbox/drozdovapb/poptranscr/2022-08-05-mtDNA
#2024-04-10
export ref=KX341964_Ecy_mt_complete_genome.fasta
export refgb=KX341964_Ecy_mt_complete_genome.gb
bowtie2-build $ref $ref.ind
export samplename=EcyBK_Naumenko
export fq1=/media/tertiary/RNAseq_reads_SRA/Eulimnogammarus_cyaneus/SRR3467057_1.fastq.gz
export fq2=/media/tertiary/RNAseq_reads_SRA/Eulimnogammarus_cyaneus/SRR3467057_2.fastq.gz 
export samplename=EcyBK_Naumenko
## run bowtie2 to filter the reads
bowtie2 -x $ref.ind --al-conc $samplename.fq -p 8 --very-sensitive-local -N 1 -L 10 -1 $fq1 -2 $fq2 -S sam
## now to MitoFinder: assemble & annotate with megahit & metaspades
#cd MitoFinder
## run MitoFinder on filtered reads
/media/secondary/apps/MitoFinder/mitofinder -j ${samplename}_filt_metaspades -1 EcyBK_Naumenko.1.fq -2 EcyBK_Naumenko.2.fq -r KX341964_Ecy_mt_complete_genome.gb -o 5 -p 8 -m 10  --metaspades
/media/secondary/apps/MitoFinder/mitofinder -j ${samplename}_filt_metaspades -1 EcyBK_Naumenko.1.fq -2 EcyBK_Naumenko.2.fq -r KX341964_Ecy_mt_complete_genome.gb -o 5 -p 8 -m 10  --metaspades
#System information:
#  SPAdes version: 3.15.3
#  Python version: 3.10.12
#  OS: Linux-5.15.0-47-generic-x86_64-with-glibc2.35
# Creating GFF and fasta files.
# Note:
# 12 genes were found in mtDNA_contig_1
# 12 genes were found in mtDNA_contig_2
# 3 genes were found in mtDNA_contig_3
## Final sequence saved to /media/main/sandbox/drozdovapb/poptranscr/2022-08-05-mtDNA/EcyBK_Naumenko_filt_metaspades/EcyBK_Naumenko_filt_metaspades_MitoFinder_metaspades_mitfi_Final_Results/
## Checked: they are 100% identical except for ND4, where one is a little bit shorter (longer kept, that's in the log).
```

+ other genomes were ready

* Manually added sequences to the alignments
* mafft alignment
* Sanity checks + trimming to the shortest length with UGENE
* tree with IQ-TREE

```
cd ./0_sequences_by_gene/
for file in *fa; do mafft --auto $file > $file.aln; done
for file in *aln; do ~/lib/trimAl/source/trimal -in $file -out $file.trim.aln.fa -nogaps; done ## .fa extension is needed for BEAST!
mv *aln ../1_alignments/
mv *trim.aln.fa ../2_trimmed_alignments/
cd ../
iqtree2 -p 2_trimmed_alignments/ -bb 1000 -abayes -o Acanthogammarus_victorii_KX341962
mv 2_trimmed_alignments.* 3_tree/

Best-fit model according to BIC: 
TPM2+F+G4:COX1.fa.aln.trim.aln.fa,

HKY+F+I:ATP6.fa.aln.trim.aln.fa,
HKY+F+I:ATP8.fa.aln.trim.aln.fa,
HKY+F+I:COX3.fa.aln.trim.aln.fa,
HKY+F+I:ND6.fa.aln.trim.aln.fa,
HKY+F+I:rrnS.fa.aln.trim.aln.fa

HKY+F+G4:ND1.fa.aln.trim.aln.fa,
HKY+F+G4:ND3.fa.aln.trim.aln.fa,
HKY+F+G4:ND4L.fa.aln.trim.aln.fa,
HKY+F+G4:COX2.fa.aln.trim.aln.fa,

TPM3+F+G4:CYTB.fa.aln.trim.aln.fa,
TPM3+F+G4:ND4.fa.aln.trim.aln.fa,
TPM3+F+G4:rrnL.fa.aln.trim.aln.fa,

TIM2+F+G4:ND2.fa.aln.trim.aln.fa,

TN+F+I:ND5.fa.aln.trim.aln.fa,

## let's say it's all HKY?

for file in *fa;do sed -e's/ .*//' $file >$file.fa; done

iqtree2 -p 2_trimmed_alignments -bb 1000 -abayes -o Acanthogammarus_victorii_KX341962
```

* Tree figure: `draw_tree.R`
