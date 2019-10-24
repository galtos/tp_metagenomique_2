#!/bin/bash

dossier_reads_bruts=$1
dossier_sortie=$2

mkdir $dossier_sortie
mkdir $dossier_sortie/aligne
mkdir $dossier_sortie/megahit
mkdir $dossier_sortie/predit

for file in $(ls $dossier_reads_bruts/EchG_R1.fastq.gz);do
    file_R1=$file
    file_R2=$(echo $file|sed "s:R1:R2:g")
    file_R=$(echo $file|sed "s:R1.fastq.gz:R:g"|sed "s:fastq/::g")
    #./soft/bowtie2 -x databases/all_genome.fasta -1 $file_R1 -2 $file_R2 -p 6 --end-to-end --fast -S $dossier_sortie/aligne/$file_R.sam
    #soft/samtools-1.6/samtools view $dossier_sortie/aligne/$file_R.sam -b -o $dossier_sortie/aligne/$file_R.bam -@ 6
    #soft/samtools-1.6/samtools sort $dossier_sortie/aligne/$file_R.bam -o $dossier_sortie/aligne/$file_R_sort.bam -@ 6
    #soft/samtools-1.6/samtools index $dossier_sortie/aligne/$file_R_sort.bam -@ 6
    #soft/samtools-1.6/samtools idxstats $dossier_sortie/aligne/$file_R_sort.bam -@ 6 > $dossier_sortie/aligne/$file_R"_sort_stats.txt"
    #grep ">" databases/all_genome.fasta|cut -f 2 -d ">" >$dossier_sortie/aligne/association.tsv
    #./soft/megahit --mem-flag 0 -t 6 --k-list 21 -1 $file_R1 -2 $file_R2 -o $dossier_sortie/megahit/$file_R
    #./soft/prodigal -i $dossier_sortie/megahit/EchG_R/final.contigs.fa -d $dossier_sortie/predit/gene_contigs.fna
    #sed "s:>:*\n>:g" $dossier_sortie/predit/gene_contigs.fna | sed -n "/partial=00/,/*/p"|grep -v "*" > $dossier_sortie/predit/genes_full.fna
    ./soft/blastn -db databases/resfinder.fna -query $dossier_sortie/predit/genes_full.fna -evalue 1E-3 -perc_identity 80 -qcov_hsp_perc 80 -out $dossier_sortie/predit/genes_annotes.out
done
