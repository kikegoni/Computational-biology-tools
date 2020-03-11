# Generate bigwigs for cell ranger count output   

From the output files of cell ranger count, it splits the bam file (possorted) in *N* sub-bamfiles for each *N* original cluster (each cluster has several barcodes). Then intersect that with the peaks (bed) and creates a bigwig for each cluster to see the coverage per track.  

## Software requirements  

1) Install [Conda](https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html)  

2) Get the conda environment:   
 &nbsp;&nbsp;&nbsp;&nbsp;* Download the *enviroment.yml*  
 &nbsp;&nbsp;&nbsp;&nbsp;* Create the environment: ``` conda env create -f environment.yml --name scATAC_bigwigs```   
 
3) Use it in **STILETTO**. Due to compatibitilies with the VNCserver
 
  &nbsp;
  
 ## The *sh* file  
 
 
 This is the script that has t bu run. It is run by:  
 ```
 sh generate_generic_bigwigs.sh $SC_DIRECTORY
 ```
   
 Where:  
 
 **SC_directory** : Path to the scATACseq directory (Mandatory). Paths according to the default [cell ranger count](https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/output/overview) structure.
 
 Some parameters in the *sh* script **can also be optionally modified** by the user:  
 &nbsp;&nbsp;&nbsp;&nbsp;-**ANNOTATION_FILE** (Line 7) : CSV file that assign each barcode to one cluster (default: *$SC_DIRECTORY/outs/analysis/clustering/graphclust/clusters.csv*).  
 &nbsp;&nbsp;&nbsp;&nbsp;-**BAM_FILE** (Line 8) :  The bam file with all the alignments that we are going to slip in N clusters (default: *$SC_DIRECTORY/outs/possorted_bam.bam*).  
 &nbsp;&nbsp;&nbsp;&nbsp;-**PEAKS_FILE** (Line 9) : The bed file with the coordinates of the peaks of the experiment (default: *$SC_DIRECTORY/outs/peaks.bed*).    
     
  &nbsp;&nbsp;&nbsp;&nbsp;-*The number of cores in the bamCoverage can also be changed (Line 37, parameter p). Default: 4*.  
 
 &nbsp;
 
 ## Run the script
 
 
 1) Activate the conda environment: ``` conda activate scATAC_bigwigs```  
 
 2) Download the *generate_generic_bigwigs.sh*.  
 
 3) ``` sh generate_generic_bigwigs.sh $SC_DIRECTORY ```  

  &nbsp;
  
## Visualize the bigwigs with IGV-VNC

Please, refer to the VNC guide:
 
