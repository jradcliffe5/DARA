## Part 1: CASA Basic EVN Calibration

### Guidance for calibrating EVN data using CASA

This guide uses capabilities of CASA 4.7.2; CASA 5+ does work apart from the Tsys calibration step (and the script isn't fixed yet, see Issue #1).

It is suitable for good-quality EVN data which does not require the use of 'rate' in calibration. It also requires a prepared gaincurve table and helper scripts if you are starting from the fitsidi data. You need about 20 G disk space, although one could manage with less by moving early versions of these files to storage.


1. [Data and supporting material](#Data_and_supporting_material)
2. How to use this guide
3. Data loading and inspection
  a. Load data and correct for Earth rotation
  b. Fix antenna and Tsys tables
  c. Inspect and flag data
4. Frequency-related calibration
  a. Delay calibration
  b. Pre-bandpass time-dependent phase correction
  c. Bandpass correction
5. Apply calibration and split out phase-ref - target pairs
6. Apply the initial calibration
7. Split out each pair of sources

### 1. <a name="Data_and_supporting_material"></a>Data and supporting material
