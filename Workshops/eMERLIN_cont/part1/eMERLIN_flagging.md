# Part 1: 3C277.1 flagging

##### [<< Return to homepage](../../../index.md)
##### [<< Return to eMERLIN Workshop](../overview_page.md)


3C277.1 is a twin-lobed radio galaxy. These C-band (4-7.3 GHz) e-MERLIN observations were made specifically for this tutorial but previous MERLIN and VLA images have been published by [Ludke et al. 1998](http://adsabs.harvard.edu/abs/1998MNRAS.299..467L) and [Cotton et al. 2006](http://adsabs.harvard.edu/abs/2006A%26A...448..535C).

### <a name="top">Data required and pre-processing</a>
The data have already been converted from `fitsidi` to a Measurement Set (MS), and preparatory steps such as correcting the uv coordinates and averaging have been performed. You need to have:


* [all_avg.ms.tar](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/3C277_eMERLIN/all_avg.ms.tar) (1.6 G plus another 1.6 G to extract it).
* [3C277.1_flag_skeleton.py](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/3C277_eMERLIN/3C277.1_flag_skeleton.py): script equivalent of the guide
* [3C277.1_flag_all.py.gz](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/3C277_eMERLIN/3C277.1_flag_all.py.gz): compressed version for reference if you get stuck
* [all_avg_1.flags](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/3C277_eMERLIN/all_avg_1.flags): list of flags

1. [Check data: listobs and plotants (step 1)](#check_data)
2. Identify 'late on source' bad data (step 2)
3. Flag the bad data at the start of each scan (step 3)
4. Flag the bad end channels (step 4)
5. Identify and flag remaining bad data (step 5)


The task names are given below. You need to fill in one or more parameters and values where you see \*\*\*. Use the help in CASA, e.g. for `flagdata`

```py
taskhelp                           # list all tasks
inp(flagdata)                      # possible inputs to task
help(flagdata)                     # help for task  
help(par.mode)                     # help for a particular input (only for some parameters)
```

### <a name="check_data">Check data: listobs and plotants (step 1)</a>

Check that you have `all_avg.ms` in a directory with enough space and start CASA.

Enter the parameter to specify the MS and, optionally, the parameter to write the listing to a text file.

```py
# in CASA
listobs(***)
```
