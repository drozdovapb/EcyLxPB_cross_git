  502  export ref=KX341964_Ecy_mt_complete_genome.fasta
  503  export refgb=KX341964_Ecy_mt_complete_genome.gb
  504  ls KX*
  505  bowtie2-build $ref $ref.ind
  506  export samplename=EcyBK_Naumenko
  507  export fq1=/media/tertiary/RNAseq_reads_SRA/Eulimnogammarus_cyaneus/SRR3467057_1.fastq.gz
  508  export fq2=/media/tertiary/RNAseq_reads_SRA/Eulimnogammarus_cyaneus/SRR3467057_2.fastq.gz 
  509  export samplename=EcyBK_Naumenko
  510  ./bowtie_and_mitofinder.sh 
  511  cp ./bowtie_and_mitofinder.sh mitofinder_sp.sh
  512  nano mitofinder_sp.sh 
  513  cat /media/main/sandbox/drozdovapb/poptranscr/2022-08-05-mtDNA/MitoFinder/EcyBK_Naumenko_filt_metaspades/metaspades.log

## 
System information:
  SPAdes version: 3.15.3
  Python version: 3.10.12
  OS: Linux-5.15.0-47-generic-x86_64-with-glibc2.35

## AttributeError: module 'collections' has no attribute 'Hashable'
##  
  514  pip install --upgrade PyYaml ##changed 
  515  chmod +x mitofinder_sp.sh 
  516  ./mitofinder_sp.sh 
  517  nano ./mitofinder_sp.sh 
  518  echo $fq1
  519  echo $fq2
  520  /media/secondary/apps/MitoFinder/mitofinder -j ${samplename}_filt_metaspades -1 $fq1 -2 $fq2 -r ../KF690638_Eve_mt_complete_genome.gb -o 5 -p 8 -m 10  --metaspades --override
  521  /media/secondary/apps/MitoFinder/mitofinder -j ${samplename}_filt_metaspades -1 $fq1 -2 $fq2 -r KX341964_Ecy_mt_complete_genome.gb -o 5 -p 8 -m 10  --metaspades --override
  522  cat /media/main/sandbox/drozdovapb/poptranscr/2022-08-05-mtDNA/EcyBK_Naumenko_filt_metaspades/metaspades.log
  523  python
  524  nano /media/secondary/apps/MitoFinder/mitofinder
  525  cat /media/main/sandbox/drozdovapb/poptranscr/2022-08-05-mtDNA/EcyBK_Naumenko_filt_metaspades/metaspades.log
  526  nano /media/secondary/apps/MitoFinder/metaspades/share/spades/pyyaml3/constructor.py
  527  /media/secondary/apps/MitoFinder/mitofinder -j ${samplename}_filt_metaspades -1 $fq1 -2 $fq2 -r KX341964_Ecy_mt_complete_genome.gb -o 5 -p 8 -m 10  --metaspades --override
  528  echo $fq1
  529  echo $fq2
  530  ls
  531  ls -alht |head
  532  /media/secondary/apps/MitoFinder/mitofinder -j ${samplename}_filt_metaspades -1 EcyBK_Naumenko.1.fq -2 EcyBK_Naumenko.2.fq -r KX341964_Ecy_mt_complete_genome.gb -o 5 -p 8 -m 10  --metaspades --override
  533  history > 20240410history_EcyBK.txt


drozdovapb@server:~/poptranscr/2022-08-05-mtDNA$ cat bowtie_and_mitofinder.sh 
## run bowtie2 to filter the reads
bowtie2 -x $ref.ind --al-conc $samplename.fq -p 8 --very-sensitive-local -N 1 -L 10 -1 $fq1 -2 $fq2 -S sam
## now to MitoFinder: assemble & annotate with megahit & metaspades
cd MitoFinder
export fq1=../$samplename.1.fq
export fq2=../$samplename.2.fq
/media/secondary/apps/MitoFinder/mitofinder -j ${samplename}_filt_megahit -1 $fq1 -2 $fq2 -r ../KF690638_Eve_mt_complete_genome.gb -o 5 -p 8 -m 10
/media/secondary/apps/MitoFinder/mitofinder -j ${samplename}_filt_metaspades -1 $fq1 -2 $fq2 -r ../KF690638_Eve_mt_complete_genome.gb -o 5 -p 8 -m 10  --metaspades 


Creating GFF and fasta files.

Note:
12 genes were found in mtDNA_contig_1
12 genes were found in mtDNA_contig_2
3 genes were found in mtDNA_contig_3

WARNING: ATP8 has been found more than once (2) in the different mitochondrial contigs.
MitoFinder selected the longest sequence as the final sequence.

WARNING: COX2 has been found more than once (2) in the different mitochondrial contigs.
MitoFinder selected the longest sequence as the final sequence.

WARNING: COX3 has been found more than once (2) in the different mitochondrial contigs.
MitoFinder selected the longest sequence as the final sequence.

WARNING: CYTB has been found more than once (2) in the different mitochondrial contigs.
MitoFinder selected the longest sequence as the final sequence.

WARNING: COX1 has been found more than once (2) in the different mitochondrial contigs.
MitoFinder selected the longest sequence as the final sequence.

WARNING: ATP6 has been found more than once (2) in the different mitochondrial contigs.
MitoFinder selected the longest sequence as the final sequence.

WARNING: ND4L has been found more than once (2) in the different mitochondrial contigs.
MitoFinder selected the longest sequence as the final sequence.

WARNING: ND3 has been found more than once (2) in the different mitochondrial contigs.
MitoFinder selected the longest sequence as the final sequence.

WARNING: ND2 has been found more than once (2) in the different mitochondrial contigs.
MitoFinder selected the longest sequence as the final sequence.

WARNING: ND5 has been found more than once (2) in the different mitochondrial contigs.
MitoFinder selected the longest sequence as the final sequence.

WARNING: ND4 has been found more than once (2) in the different mitochondrial contigs.
MitoFinder selected the longest sequence as the final sequence.

WARNING: ND6 has been found more than once (2) in the different mitochondrial contigs.
MitoFinder selected the longest sequence as the final sequence.

## Final sequence saved to /media/main/sandbox/drozdovapb/poptranscr/2022-08-05-mtDNA/EcyBK_Naumenko_filt_metaspades/EcyBK_Naumenko_filt_metaspades_MitoFinder_metaspades_mitfi_Final_Results/

## They are 100% identical except for ND4, where one is a little bit shorter (longer kept, that's in the log).


