# Clustering-GNN
 Code for 'Alzheimer’s Disease Classification Using Cluster-based Labelling for Graph Neural Network on Tau PET Imaging and Heterogeneous Data '

## Dataset generation
This R script uses the ADNIMERGE R library (adni.loni.usc.edu) to combine demographic and neuroimaging features with individual questions from CFA features, and saves them as CSV files. TAU-PET features were processed using SVM based on ADNI data. Original data is available from ADNI; processed TAU-PET data can be made available upon request from the corresponding author if permission is obtained from ADNI.  

## Data pre-processing. 
Most of the data processing is done in GNN data prep.ipynb. This normalises the data and exports it as numpy arrays, performs the UMAP clustering, draws the graphs for Figure 1, generates and labels the clusters, and generates the relabelled data. It also exports data with cluster labels in csv format so that further data analysis can be conducted in R

## Run GNN
This code runs the graphical neural network using the numpy data exported at the previous step. It is based on the GitHub repository at;  the imported library files for the graphical neural network are available there. 

## Cluster Analysis
This R script uses the CSV exported at the data pre-processing step to select the most informative features relative to each cluster labels, and amalgamates the CSF Amyloid Beta data with the features that were used for clustering. 
