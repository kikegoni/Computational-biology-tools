# What  is the purpose of this tool?   

This tool creates bigWigs from pseudobulk reads for each cluster called by CellRanger. For this the tool automatically, splits the bam file (possorted.bam) into *n* (*n*=number of clusters) bamfiles with the reads associated with each cluster. In the process it will remove any reads not associated with cell/nuclei barcodes (i.e. barcodes associated with empty droplets) and reads that are not falling into peaks. 

 &nbsp;
 
## Software installation 

1) Install [Conda](https://docs.conda.io/projects/conda/en/latest/user-guide/install/linux.html)  

2) Get the conda environment:   
 &nbsp;&nbsp;&nbsp;&nbsp;* Download the *enviroment.yml*  
 &nbsp;&nbsp;&nbsp;&nbsp;* Create the environment: ``` conda env create -f environment.yml --name scATAC_bigwigs```   
 
3) Use it in **STILETTO**. Due to compatibitilies with the VNCserver
 
  &nbsp;
  
 ## Parameters for the tool
 
 
 To run the tool simply run the following command and replace the $SC_DIRECTORY with the location of your CellRanger output:  
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
 
 ## Running the tool
 
 
 1) Activate the conda environment: ``` conda activate scATAC_bigwigs```  
 
 2) Download the *generate_generic_bigwigs.sh*.  
 
 3) ``` sh generate_generic_bigwigs.sh $SC_DIRECTORY ```  

  &nbsp;
  
## Output  

``` $SC_DIRECTORY/bigwigs``` contains the *n* bigWigs.  
``` $SC_DIRECTORY/intermediate_files``` contains the *n* bam files, for all the reads and for only reads falling in peaks.
  
## Visualize the bigWigs with IGV-VNC

Refer to the [VNC guide](https://github.com/kikegoni/Computational-biology-tools/blob/master/VNCServer_setup.md):
 
