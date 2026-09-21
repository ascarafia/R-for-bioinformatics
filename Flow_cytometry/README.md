# FLOW CYTOMETRY ANALYSIS

## Script 1 - - - 2-AXIS PLOT - - - - 

The script 1 takes as input csv tables of fluorescence, assuming compensation and gating of singlets (single cells) has been done inside the software of the cytometer. 
You can follow this [video tutorial](https://www.youtube.com/watch?v=TdzVxcGLVzU&t=37s) to see how this was done and export the data for plotting (minutes from 0 to 4:16).
Don't forget that this analysis comes from one replicate of a 3-replicate experiment, and as such, is meant to be representative of the results you see consistently across replicates. This type of representative figure is supposed to be accompained by a summary plot describing all measures obtained from the 3 replicates (such as a bar plot with percentages, with a statical analysis stating whether the results are significant).


Required arguments:
```bash
Rscript <script name> <metadata file> <name of channel y-axis> <name of channel x-axis> <name of gene y-axis> <name of gene x-axis>
```
Example command:
```bash
Rscript 1_flow_cytometry_from_csv.R example_metadata.txt FL1.A FL4.A NKX2.5 TNNT2
```

The Metadata table must be a tab separated text file, indicating condition and its corresponding file name:
| condition | file_name             |
|-----------|------------------------|
| control   | example_control.csv   |
| wildtype  | example_wildtype.csv  |
| knockout  | example_knockout.csv  |

Output: 
the scripts generates a pdf file named cytometry_hexplot.pdf (you can find the plot generated using the example data provided whithin this folder).

<img width="6009" height="2409" alt="hexplot" src="https://github.com/user-attachments/assets/2a71798f-d6b0-461d-9723-b50ef2885b79" />


