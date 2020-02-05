# Performance and Interpretation of Deep Learning Classifiers for Genotypic HIV-1 Drug Resistance Prediction

Repository for data & code used in manuscript. All code is written in R. 

## Data Scripts

CSV files: input from Stanford database (https://hivdb.stanford.edu). Data cleaning files: generate drug-specific datasets from CSV files. Sequence_maker.R: Functions to create FASTA files. FASTA script files: scripts to generate fastas from output of data cleaning files.

## FASTA Files

Output of data script files.

## Figures

Scripts used to generate figures. imp_plots_script.R: top-20 feature importance plots. new_impplots_script_sequence.R: whole-gene feature importance plots. roc_script_mlp.R, roc_script_cnn.R, roc_script_brnn.R: ROC curve plots.

## Test Scripts

Scripts to train & evaluate all classifiers.

## Results

Output files of test scripts.
