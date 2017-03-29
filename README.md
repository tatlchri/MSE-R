# Maximum Score Estimator

This code was designed by Theodore Chronis and Christina Tatli in collaboration with Denisa Mindruta.

The code builds upon Jeremy Fox’s theoretical work on the “pairwise maximum score estimator” (Fox 2010; Fox 2016) and the original Match Estimation toolkit (Santiago and Fox, 2009) which can be downloaded from http://fox.web.rice.edu/

To understand the present code the user needs to be familiar with the maximum score estimator and formal matching games. To ease the exposition, this documentation and the code itself follow closely the terminology used by Jeremy Fox. Unless stated otherwise, please refer back to the original sources for definitions and technical details accessible via the links at the bottom of this document.  

## Installation Instructions

1. Download the zip file (https://github.com/tatlchri/MSE-R/archive/master.zip)

2. Extract the downloaded compressed file MSE-R-master.zip

3. Goto examples/ and open any of the examples to experiment with specific cases

4. Make sure you have set the correct library path at the beginning of your notebooks


## Documentation

A full description of all upgrades can be found under doc/MSE-R.docx

https://github.com/tatlchri/MSE-R/blob/master/doc/MSE-R.docx

The code is broken down to several files that are all tied together through the main library file **mse.R** , which must be loaded before calling any MSE function described in doc/functions-reference.docx

https://github.com/tatlchri/MSE-R/blob/master/doc/functions-reference.docx 

For a more complete




## Files List

 ## Directory Structure

 | Directory     | Description   |
 | ------------- | -------------- |
 | doc/          | Documentation Files |
 | import/       | Data files used in examples |
 | examples/     | Various flows examples |
 | testing/      | Testing routines |
 | .gitignore    | Exclude certain files and directories in your working directory |
 | LICENSE       | A short and simple permissive license with conditions only requiring preservation of copyright and license notices. |
 | README.md     | This file |
 | import.R      | Importing data routines |
 | mse.R         | Main Library file to load |
 


## References

David Santiago and Fox, Jeremy. “A Toolkit for Matching Maximum Score Estimation and Point and Set Identified Subsampling Inference”. 2009. Last accessed from http://fox.web.rice.edu/computer-code/matchestimation-452-documen.pdf

Fox, Jeremy, “Estimating Matching Games with Transfers,” 2016. Last accessed from http://fox.web.rice.edu/working-papers/fox-matching-maximum-score.pdf

Fox J. 2010. Identification in matching games. Quantitative Economics 1: 203–254
