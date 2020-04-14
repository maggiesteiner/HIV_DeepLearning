#  Drug Resistance Prediction Using Deep Learning Techniques on HIV-1 Sequence Data

This repository contains code used to train and evaluate deep learning classifiers for HIV-1 drug resistance prediction from sequence data (Steiner et al., 2020, _in review_). All code is written in R, and all classifiers are developed and trained using the R interface to [Keras](https://keras.rstudio.com). All data is publicly available via the [Stanford HIV Drug Resistance Database](https://hivdb.stanford.edu).

**Citation information:** 
When referencing this project, please cite our recent publication (citation & link will be added here).

## Code and Data Files
### Data Scripts

CSV files: input from Stanford database (https://hivdb.stanford.edu). Data cleaning files: generate drug-specific datasets from CSV files. Sequence_maker.R: Functions to create FASTA files. FASTA script files: scripts to generate fastas from output of data cleaning files.

### FASTA Files

Output of data script files.

### Figures

Scripts used to generate figures. imp_plots_script.R: top-20 feature importance plots. new_impplots_script_sequence.R: whole-gene feature importance plots. roc_script_mlp.R, roc_script_cnn.R, roc_script_brnn.R: ROC curve plots. histogram_script.R: histograms from feature importance data.

### Test Scripts

Scripts to train & evaluate all classifiers.

### Results

Output files of test scripts.

## Helpful Resources

ADD
