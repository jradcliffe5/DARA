## Part2: Calibration and imaging of J1849+3024
##### [<< Return to homepage](../../../index.md)
##### [<< Return to EVN continuum](../overview_page.md)

This page expects that you have completed [part 1](../part1/part1_initial_cal.md) to get as far as applying the Tsys/gain curve, initial delay and bandpass corrections to all sources and split out 1848+283_J1849+3024.ms (and also to become familiar with the basics of CASA).

A new MS contains just a 'data' column. The previous `applycal` made a copy of the data with calibration applied, writing a 'corrected' column into the MS and split then took just that column and wrote new data sets, where this becomes a 'data' column.

If you don't have a good version of 1848+283_J1849+3024.ms (remove any bad versions), get [1848+283_J1849+3024.ms.tgz](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/EVN_Continuum/1848+283_J1849+3024.ms.tgz) and extract it using `tar -zxvf 1848+283_J1849+3024.ms.tgz`.

To summarise you will need for this part:
* 1848+283_J1849+3024.ms you made at the end of the initial calibration (end of part 1)
* or, 1848+283_J1849+3024.ms.tgz (ready made)
* NME_J1849.py

1848+283_J1849+3024.ms contains phase-ref 1848+283 and target J1849+3024. You should have 1848+283_J1849+3024.ms.listobs made at the end of CASA_Basic_EVN which shows the interleaving of the target and phase-ref.

```
13:23:20.0 - 13:24:20.0    38      1 1848+283                 18720  [0,1,2,3,4,5,6,7]  [2, 2, 2, 2, 2, 2, 2, 2]
13:25:00.0 - 13:26:00.0    39      0 J1849+3024               18720  [0,1,2,3,4,5,6,7]  [2, 2, 2, 2, 2, 2, 2, 2]
13:26:40.0 - 13:27:40.0    40      1 1848+283                 18720  [0,1,2,3,4,5,6,7]  [2, 2, 2, 2, 2, 2, 2, 2]
13:28:20.0 - 13:29:20.0    41      0 J1849+3024               15840  [0,1,2,3,4,5,6,7]  [2, 2, 2, 2, 2, 2, 2, 2]
13:30:00.0 - 13:31:00.0    42      1 1848+283                 15840  [0,1,2,3,4,5,6,7]  [2, 2, 2, 2, 2, 2, 2, 2]
...
```
Before we start:
* Look at the script in a text editor (e.g. `gedit`).

**Important:** Each step contains one or a few tasks which perform a step in calibration or imaging. It is not completely automatic because it expects interactive imaging, and you need to inspect some of the plots to check and/or to make decisions. The source names and some other parameters are set as variables so the script could be used as a template for other similar data reduction. The `taskname(parameter=value)` way of running a task automatically sets all unspecified parameters to default. Use `inp` task or `help` task at the CASA prompt to check before running a task.

The following calibration script will go through the following (note that the steps correspond to the `NME_J1849.py` script):

1. [Initial inspection of data (step 1)](#Initial_inspection)
2. Calibration using the phase-reference source
  * Time-dependent delay and phase calibration (step 2)
3. Apply phase solutions and image phase-ref(step 3)
  * Check for remaining bad data (step 4)
  * Time-dependent amplitude calibration (step 5)
  * Apply amplitude and phase solutions to the phase-ref (step 6)
  * Clean the calibrated phase-ref (step 7)
  * Uncalibrated target image (step 8)
  * Apply all calibration to the target (step 9)
4. Imaging and self-calibration of the target
  * Split out target 2 and image (step 10)
  * Self-calibrate target phase only and apply (step 11)
  * Image phase-self-calibrated target (step 12)
  * Self-calibrate target amplitude and phase and apply (step 13)
  * Image the amplitude and phase self-calibrated target (step 14)

### 1. <a name="Initial_inspection">Initial inspection of data (step 1)</a>

```python
# In CASA

mysteps=[1]
execfile('NME_J1849.py')
```

Page through the plots. The phase-ref is in red, target in black. The phase offsets for both sources follow a similar pattern per baseline and correlation, so the phase-reference solutions should also correct the target OK. Note that JB misses every other pair of scans.

![](files/CASA_1848+283_J1849+3024.png "phase_time")
