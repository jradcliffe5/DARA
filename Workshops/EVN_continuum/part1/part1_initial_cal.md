## Part 1: CASA Basic EVN Calibration

##### [<< Return to homepage](../../../index.md)
##### [<< Return to EVN continuum](../overview_page.md)

### Guidance for calibrating EVN data using CASA

This guide uses capabilities of CASA 4.7.2; CASA 5+ does work apart from the Tsys calibration step (and the script isn't fixed yet, see Issue #1).

It is suitable for good-quality EVN data which does not require the use of 'rate' in calibration. It also requires a prepared gaincurve table and helper scripts if you are starting from the fitsidi data. You need about 20 G disk space, although one could manage with less by moving early versions of these files to storage.


1. [Data and supporting material](#Data_and_supporting_material)
2. [How to use this guide](#How_to_use_this_guide)
3. [Data loading and inspection](#Data_loading_and_inspection)
  * [Load data and correct for Earth rotation](#Load_data_earth_rot)
  * Fix antenna and Tsys tables
  * Inspect and flag data
4. Frequency-related calibration
  * Delay calibration</li>
  * Pre-bandpass time-dependent phase correction</li>
  * Bandpass correction
5. Apply calibration and split out phase-ref - target pairs
6. Apply the initial calibration
7. Split out each pair of sources

### 1. <a name="Data_and_supporting_material">Data and supporting material</a>

n14c3 is an EVN network monitoring experiment. It contains two target - phase-reference pairs of bright sources (plus a 5th source which we will not use). The full data reduction here needs:

* Raw data (fits IDI files from the JIVE correlator)
  - n14c3_1_1.IDI1,
  - n14c3_1_1.IDI2
* Gain curve and Tsys tables (specially prepared for this data set by Mark Kettenis and Anita Richards)
  - n14c3.gc
  - n14c3.antab
* Helper scripts by Mark Kettenis to convert the .antab Tsys table to the correct format
  - key.py
  - tsys_spectrum.py
* Flag command files. You can write these yourself but to save time you can use some or all of these
  - flagSH.flagcmd
  - flagSH1.flagcmd
  - flagTar1Ph1.flagcmd

These are all provided on your desktop for the DARA workshops, but the fits IDI files can also be obtained from [here](http://www.jive.nl/fitsfiles?experiment=N14C3_141022) along with more information about the observations. The other files are available [here](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/EVN_Continuum/NME_DARA.tgz)

* List of data reduction scripts and intermediate data products for each part
  - Part1: Initial data inspection and calibration common to all sources: files listed above. Optional NME_all.py is a script version of the commands, for your future reference.
  - Part2: Further calibration and imaging of 1848+283/J1849+3024.
    * 1848+283_J1849+3024.ms you made at the end of the initial calibration (end of part 1)
    * or, 1848+283_J1849+3024.ms.tgz (ready made)
    * NME_J1849.py
  - Part3: Further calibration and imaging of J1640+3946/3C345.
    * J1640+3946_3C345.ms you made at the end of the initial calibration (end of Part 1)
    * or, J1640+3946_3C345.ms.tgz (ready made);
    * NME_3C345_skeleton.py
    * (NME_3C345.py.gz is complete script for future reference)

These are the sources:

| Number | Name | Position (J2000) | Role |
| :----: | :----: | :----: | :----: |
|0 | J1640+3946  | 16:40:29.632770 +39.46.46.02836 | target |
|1 | 3C345 | 16:42:58.809965 +39.48.36.99402 | phase-cal |
|2  |  J1849+3024  |  18:49:20.103406 +30.24.14.23712 | target |
|3 |    1848+283 |   18:50:27.589825 +28.25.13.15523 |phase-cal |
| 4 | 2023+336  | 20:25:10.842114 +33.43.00.21435 |not used |

J1849+3024 is also used as bandpass calibrator because it is a bright, compact source with good data on all baselines. If you are reducing a new data set, you would check the suitability of the bandpass calibrator during early data reduction.

### 2. <a name="How_to_use_this_guide">How to use this guide</a>

This web page presents inputs for CASA tasks to be entered interactively at a terminal prompt for the calibration of the averaged data and initial target imaging. This is useful to examine your options and see how to check for syntax errors.

* To begin with, work interactively to see what each parameter is for. This is used for the initial steps and calibration common to all sources.
* Calibrate and image one phase-reference and target using a script (`NME_J1849.py`).
* Use this information to enter parameters and values in `NME_3C345_skeleton.py` for the other phase-ref - target pair.

**To start:**

1. Make a directory called something you will remember, e.g. EVN, and work in it. (Do not do data reduction within the CASA installation).
2. Copy the data and files you need to this directory. <path***> is the original location of these files; **Note** in general, *** means something for you to fill in. e.g:

```bash
mdir EVN
cd EVN
cp <path***>/n14c3_1_1.IDI? .
cp <path***>/NME_DARA.tgz .
cp <path***>/*py .

tar -zxvf NME_DARA.tgz          # extract the additional material (also the scripts  which will be supplied).
```

### 3. <a name="#Data_loading_and_inspection">Data loading and inspection</a>

* Check that you are in the right place with all the data.

```bash
pwd                   # tells you present working directory
ls
which should show

flagSH1.flagcmd      key.py          n14c3.antab        NME_3C345_skeleton.py  NME_J1849.py
flagSH.flagcmd       n14c3_1_1.IDI1  n14c3.gc           NME_all.py             tsys_spectrum.py
flagTar1Ph1.flagcmd  n14c3_1_1.IDI2  NME_3C345.py       NME_DARA.tgz
```

* Now start CASA.

#### <a name="#Load_data_earth_rot">a. Load data and correct for Earth rotation

The first task is `importfitsidi` which converts the fits files to CASA-amicable Measurement Sets (MS). Copy these lines one at a time (when you get more familiar, some inputs can be copied together).

```python
# in CASA
os.system('rm -rf n14c3_prefix.ms*')              # make sure no old files are present

default(importfitsidi)                            # initialise task
inp()                                             # list all inputs

fitsidifile=['n14c3_1_1.IDI1','n14c3_1_1.IDI2']   # fits files to convert
vis='n14c3_prefix.ms'                            # output ms file name
constobsid=True                                   # data could be processed together
scanreindexgap_s=15                               # only separate scans if gap >15 sec (or source change)
inp()                                             # check your inputs

importfitsidi()                                   # if happy, execute the task
inp() provide checks that you should normally carry out but the script won't repeat these for every task.
```
