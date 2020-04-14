#  Drug Resistance Prediction Using Deep Learning Techniques on HIV-1 Sequence Data

This repository contains code used to train and evaluate deep learning classifiers for HIV-1 drug resistance prediction from sequence data (Steiner et al., 2020, _in review_). All data is publicly available via the [Stanford HIV Drug Resistance Database](https://hivdb.stanford.edu). All code was written in R, and all classifiers were developed and trained using the R interface to [Keras](https://keras.rstudio.com). Other packages used include the [IML](https://cran.r-project.org/web/packages/iml/vignettes/intro.html) package for model interpretation and [ggplot2](https://ggplot2.tidyverse.org) for data visualization.

**Author:** Margaret C. Steiner ([GitHub](https://github.com/maggiesteiner)), Computational Biology Institute, The George Washington University

**Citation information:** 
When referencing this project, please cite our recent publication (citation & link will be added here).

## Code and Data Files

Below are brief descriptions of the files included in this repository.

### Data Scripts

These files were used for cleaning and formatting the raw data.

`NNRTI_stanford.csv`, `NRTI_stanford.csv`, and `PI_stanford.csv` are raw data files downloaded from the Stanford database. 
 
`datacleaning_file_NNRTI.R`,  `datacleaning_file_NRTI.R`, and  `datacleaning_file_PI.R` clean the raw files and separate the data into drug-specific dataframes.
 
`sequence_maker.R` includes functions to generate FASTA files from the dataframes generated in the data cleaning files. `fastascriptNNRTI.R`,  `fastascriptNRTI.R`, and `fastascriptPI.R` call this function to generate fasta files for input into the classifiers.

### FASTA Files

Output of data script files.

### Test Scripts

Scripts to train & evaluate all classifiers.

### Figures

Scripts used to generate figures. imp_plots_script.R: top-20 feature importance plots. new_impplots_script_sequence.R: whole-gene feature importance plots. roc_script_mlp.R, roc_script_cnn.R, roc_script_brnn.R: ROC curve plots. histogram_script.R: histograms from feature importance data.

### Results

Output files of test scripts.

## Helpful Resources

- For readers interested in developing their own deep learning models in R, we recommend starting the tutorials provided [here](https://keras.rstudio.com/articles/getting_started.html). 
- For an introduction to machine learning concepts alongside R tutorials, we recommend this [book](https://www.manning.com/books/deep-learning-with-r). 
