## Spectral Line NGC660 Hydrogen Absorption
#### [<< return to home page](../../index.md)

NGC660 is a nearby starburst galaxy with hydrogen absorption against a nuclear outburst observed in 2013 (see [Argo+2015.pdf](1507.01781.pdf)). It was observed using the EVN.

The guide starts with a data set which has already been flagged and calibrated using the instrumental corrections and calibration derived from astrophysical sources including phase referencing. This was done in AIPS and the split-out, calibrated data `NGC660.FITS` are in UVFITS format.

Before starting please make sure that you have all data products below:

**DARA students, you should have these on your computers already!**

* [NGC660.FITS](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/NGC660/NGC660.FITS) UVfits data set with instrumental and calibration source corrections applied - needed to run from start of this script.
* [NGC660shift.ms.tgz](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/NGC660/NGC660shift.ms.tgz) data set for starting at step 8 (you make this yourself if working through steps 1-7).
* [NGC660_line.clean.image.tgz](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/NGC660/NGC660_line.clean.image.tgz) and [NGC660_contap1.clean.image.tgz](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/NGC660/NGC660_contap1.clean.image.tgz) images for analysis (you make these yourself, but just in case...)
* [NGC660.py](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/NGC660/NGC660.py) script covering the steps in this web page
* [NGC660.flagcmd](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/NGC660/NGC660.flagcmd) flags for step 2

If not, then use the links to download them.

The bulky files can be downloaded by copying these commands into your Linux terminal:
wget -c http://almanas.jb.man.ac.uk/DARA/NGC660/NGC660.FITS
wget -c http://almanas.jb.man.ac.uk/DARA/NGC660/NGC660shift.ms.tgz
wget -c http://almanas.jb.man.ac.uk/DARA/NGC660/NGC660_line.clean.image.tgz
wget -c http://almanas.jb.man.ac.uk/DARA/NGC660/NGC660_contap1.clean.image.tgz

If you have all the files listed above, then please go to the [guide](spectral_line_guide.md) to continue.
