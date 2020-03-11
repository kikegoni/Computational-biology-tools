#!/bin/bash

if [ "$1" != "" ]; then

	scATAC_dir=$1
	#Default parameters: Can be modified by the user
	ANNOTATION_FILE=outs/analysis/clustering/graphclust/clusters.csv
	BAM_FILE=outs/possorted_bam.bam
	PEAKS_FILE=outs/peaks.bed
	FINAL_DIRECTORY=bigwigs
	INTERMEDIATE_FILES_DIR=intermediate_files

	cd $scATAC_dir
	samtools view -H $BAM_FILE > SAM_header

	cat $ANNOTATION_FILE | awk -F "\"*,\"*" '{print $3}' | tail -n +2 | sort -u > clusters
	for i in $(cat clusters)
	do
        	echo $i
		first_grep=",${i}"
        	annotation_cluster="filter_cluster${i}.txt"
        	bam_cluster="filtered_cluster${i}.bam"
        	bam_cluster_peaks="filtered_cluster_peaks${i}.bam"
        	bigwig_cluster_peaks="filtered_cluster_peaks${i}.bw"

		cat $ANNOTATION_FILE | grep $first_grep | sed 's/,/ /'  |  awk '{print $1}' | sed -e 's/^/CB:Z:/' > $annotation_cluster
		
		samtools view $BAM_FILE | LC_ALL=C grep -F -f $annotation_cluster > filtered_SAM_body
        	cat SAM_header filtered_SAM_body > filtered.sam
        	samtools view -bS filtered.sam > $bam_cluster

        	# Filter according to peaks
        	intersectBed -abam $bam_cluster -b $PEAKS_FILE > $bam_cluster_peaks

        	# Convert to bigwigs
        	samtools index $bam_cluster_peaks
        	bamCoverage -b $bam_cluster_peaks -o $bigwig_cluster_peaks -p 4

	done

	#Save intermediate files in their directories
	mkdir -p $INTERMEDIATE_FILES_DIR
	mv filter*txt $INTERMEDIATE_FILES_DIR
	mv filter*ba[mi] $INTERMEDIATE_FILES_DIR
	mv filtered.sam $INTERMEDIATE_FILES_DIR
	mv filtered_SAM_body $INTERMEDIATE_FILES_DIR
	mv SAM_header $INTERMEDIATE_FILES_DIR
	mv clusters $INTERMEDIATE_FILES_DIR

	#Save everything in a default directory
	mkdir -p $FINAL_DIRECTORY
	mv filtered*bw $FINAL_DIRECTORY

else
    echo "You need to add the path to your scATACseq directory"
fi
