## Part 1: CASA Basic EVN Calibration

### Guidance for calibrating EVN data using CASA

This guide uses capabilities of CASA 4.7.2; CASA 5+ does work apart from the Tsys calibration step (and the script isn't fixed yet, see Issue #1).

It is suitable for good-quality EVN data which does not require the use of 'rate' in calibration. It also requires a prepared gaincurve table and helper scripts if you are starting from the fitsidi data. You need about 20 G disk space, although one could manage with less by moving early versions of these files to storage.


1. [Data and supporting material](#Data_and_supporting_material)
2. [How to use this guide](#How_to_use_this_guide)
3. Data loading and inspection
<ol type="a">
  <li>Load data and correct for Earth rotation</li>
  <li>Fix antenna and Tsys tables</li>
  <li>Inspect and flag data</li>
</ol>
4. Frequency-related calibration
<ol type="a">
  <li>Delay calibration</li>
  <li>Pre-bandpass time-dependent phase correction</li>
  <li>Bandpass correction</li>
</ol>
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
