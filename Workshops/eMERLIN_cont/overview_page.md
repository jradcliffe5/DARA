## 3C277.1 eMERLIN Workshop
#### [<< return to home page](../../index.md)

This e-MERLIN continuum tutorial is also split into three parts which should be done in order. The tutorial covers a lot of what is covered in the EVN tutorial, but also covers extra techniques such as multi-scale CLEAN. If you are running out of time, or just would like something new, then please just do part 3.

3C277.1 is a twin-lobed radio galaxy. These C-band (4-7.3 GHz) e-MERLIN observations were made specifically for this tutorial but previous MERLIN and VLA images have been published by [Ludke et al. 1998](http://adsabs.harvard.edu/abs/1998MNRAS.299..467L) and [Cotton et al. 2006](http://adsabs.harvard.edu/abs/2006A%26A...448..535C). The data have already been converted from `fitsidi` to a Measurement Set (MS), and preparatory steps such as correcting the uv coordinates and averaging have been performed. You need to have:


* [all_avg.ms.tar](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/3C277_eMERLIN/all_avg.ms.tar) (1.6 G plus another 1.6 G to extract it).
* [3C277.1_flag_skeleton.py](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/3C277_eMERLIN/3C277.1_flag_skeleton.py): script equivalent of the guide
* [3C277.1_flag_all.py.gz](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/3C277_eMERLIN/3C277.1_flag_all.py.gz): compressed version for reference if you get stuck
* [all_avg_1.flags](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/3C277_eMERLIN/all_avg_1.flags): list of flags

As stated before, there are three parts: flagging, calibration & imaging. Follow the webpages below to complete the tutorials. If you would like to skip a step of the tutorial, there are instructions on the webpages below on how to move your dataset up to the required calibration step for the tutorial.

1. [Flagging Tutorial](part1/eMERLIN_flagging.md)

2. [Calibration Tutorial](part2/eMERLIN_calibration.md)
To start step 2 (Calibration), you will need to download some extra associated scripts:
* [t2_flagging.py](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/3C277_eMERLIN/t2_flagging.py)
* [3C277.1_cal_outline.py](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/3C277_eMERLIN/3C277.1_cal_outline.py)
* [3C277.1_cal_all.py](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/3C277_eMERLIN/3C277.1_cal_all.py)

If you would like to start directly at step 2 and skip flagging then follow the instructions at the start of the calibration tutorial webpage

3. [Imaging Tutorial](part3/eMERLIN_imaging.md)
To start step 3 (Imaging), you will need to download the associated scripts (and calibrated data set if calibration went badly or you would like to start directly from step 3 and miss out the other tutorials:

Scripts:
* [3C277.1_imaging_skeleton.py](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/3C277_eMERLIN/3C277.1_imaging_skeleton.py)
* [3C277.1_imaging.py.gz](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/3C277_eMERLIN/3C277.1_imaging.py.gz)
Calibrated data set:
* [1252+5634.ms.tar](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/3C277_eMERLIN/1252+5634.ms.tar)
