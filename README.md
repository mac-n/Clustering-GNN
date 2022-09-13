# Clustering-GNN
 Code for 'Alzheimer’s Disease Classification Using Cluster-based Labelling for Graph Neural Network on Tau PET Imaging and Heterogeneous Data' Original data is available from ADNI; processed TAU-PET data can be made available upon request from the corresponding author if permission is obtained from ADNI. Python version used was Python 3.8.12, conda 4.12.0; environment available in repository as environment.yml. R scripts were run in R version R version 4.2.1 Patched (2022-07-22 r82626 ucrt) - patch allows Java based packages including FSelector, used in one of the scripts here, to run in Windows 64. 'adnimerge' R package version 0.0.1 was used to access ADNI data.


## Dataset generation
This R script "combine CFA subassessments with other data.R" uses the ADNIMERGE R library (adni.loni.usc.edu) to combine demographic and pre-processed neuroimaging features with individual questions from CFA features, and saves the output as CSV files. TAU-PET features were processed using SVM based on ADNI data. 

## Data pre-processing. 
Most of the data processing is done in GNN data prep.ipynb, which imports the CSV file generated in the previous step.  This normalises the data and exports it as numpy arrays, performs the UMAP clustering, draws the graphs for Figure 1, generates and labels the clusters, and generates and exports the relabelled data, and performs a kappa test to determine the It also exports data with cluster labels in csv format so that further data analysis can be conducted in R.

## Run GNN
This code runs the graphical neural network using the numpy data exported at the previous step. It is based on the GitHub repository at https://github.com/SJTUBME-QianLab/AutoMetricGNN;  the imported library files for the graphical neural network are available there. 

## Cluster Analysis
The R script "Get MI with cluster variable.R" uses the CSV exported at the data pre-processing step to select the most informative features for each cluster using mutual information with one-hot encoded version of the cluster labels. 

## Incorporate CSF Amyloid-Beta levels into data
The R script "Examine ABETA levels for relabelled AD cases.R" amalgamates CSF amyloid-beta levels from ADNIMERGE with the data which was used for clustering, and the cluster labels, and performs a t-test to compare the levels in cases which were relabelled,  to the levels in cases where the algorithm and clinicans agreed.  
