# HBC722

This repository is meant to accompany the publication titled "[Detection of a Disk Surrounding the Variably Accreting Young Star HBC722](https://iopscience.iop.org/article/10.3847/2515-5172/abb813)" in the Research Notes of the AAS (Volume 4, Number 9). 

## Contents of Interest

*   The `data` directory contains a `.csv` file with the key results from applying 3 rounds of self-calibration (more specifically, 2 rounds of phase self-calibration, followed by 1 round of amplitude self-calibration) to the ALMA 233 GHz continuum observations of the FU Orionis object HBC722. Note that the values are rounded up to 3 decimal places solely for vanity.
*   `disk_mass.ipynb` contains the Jupyter Notebook used to calculate the object's total circumstellar disk mass.
*   `Yek_2020.pdf` is the PDF of the final publication, downloaded from the arXiv: [https://arxiv.org/abs/2009.08019](https://arxiv.org/abs/2009.08019).
*   The `src` directory houses the LaTeX source code used to typeset `Yek_2020.pdf`.
*   `utils/continuum_detection_image.pro` is the IDL source code used to make Figure 1 of `Yek_2020.pdf`.
