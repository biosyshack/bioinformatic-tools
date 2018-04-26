# Microarray processing pipeline
Pipeline for the retrieval (GEO), normalization (RMA for Affymetrix), processing (average probes) and annotation (gene symbols) of microarray datasets.

## Recommended order of execution
1. Retrieve and normalize datasets
    retrieveGEO.R:  Retrieval and export of annotated GEO datasets
    affyNorm.R:     Retrieval and normalization of Affymetrix datasets (GEO) using robust multi-array average (RMA)
2. Average identitical probes
    probeMean.py:   Calculate mean gene expression across identical probes
3. Annotate gene expression matrix using probes to gene symbols mapping from GEO
    annoatateMA.py: Annotate processed gene expression matrix
