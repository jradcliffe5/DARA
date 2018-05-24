## Part 2: Calibration and imaging of 3C345
##### [<< Return to homepage](../../../index.md)
##### [<< Return to EVN continuum](../overview_page.md)

This page expects that you have used completed [part 1](../part1/part1_initial_cal.md) to get as far as applying the Tsys/gain curve, initial delay and bandpass corrections to all sources and split out 1848+283_J1849+3024.ms and J1640+3946_3C345.ms. Then you worked through [part2](../part2/part2_script_cal.md) where you calibrated and imaged a phase cal target pair.

### <a name="top">Preliminary steps & Outline</a>

This section is similar and follows similar operations but you now write the script yourself.

For this section ensure you have the following:

* J1640+3946_3C345.ms (produced during part1)
* OR, if you don't have a good version of J1640+3946_3C345.ms (remove any bad versions), get [J1640+3946_3C345.ms.tgz](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/EVN_Continuum/J1640+3946_3C345.ms.tgz) and extract it using `tar -zxvf J1640+3946_3C345.ms.tgz`.)
* the skeleton script `NME_3C345_skeleton.py`.
* the file `flag_Tar1Ph1.flagcmd`

**both the NME_3C345_skeleton.py and the file `flag_Tar1Ph1.flagcmd` were located in the [NME_DARA.tgz](http://www.jb.man.ac.uk/~radcliff/DARA/Data_reduction_workshops/EVN_Continuum/NME_DARA.tgz) from part1**

**Before starting**
* Copy `NME_3C345_skeleton.py` to a name of your own e.g. `cp NME_3C345_skeleton.py NME_3C345_skeleton_modified.py` so you can edit the copy (i.e. `NME_3C345_skeleton_modified.py` in this case) but you can still check the original.

`J1640+3946_3C345.ms` contains phase-ref J1640+3946 and target 3C345. You should have `J1640+3946_3C345.ms.listobs` made at the end of part 1 which shows the interleaving of the target and phase-ref.
```
12:15:20.0 - 12:16:20.0     5      0 J1640+3946               15840  [0,1,2,3,4,5,6,7]  [2, 2, 2, 2, 2, 2, 2, 2]
12:17:00.0 - 12:18:00.0     6      1 3C345                    13200  [0,1,2,3,4,5,6,7]  [2, 2, 2, 2, 2, 2, 2, 2]
12:18:40.0 - 12:19:40.0     7      0 J1640+3946               13200  [0,1,2,3,4,5,6,7]  [2, 2, 2, 2, 2, 2, 2, 2]
12:20:20.0 - 12:21:20.0     8      1 3C345                    15840  [0,1,2,3,4,5,6,7]  [2, 2, 2, 2, 2, 2, 2, 2]
12:22:00.0 - 12:23:00.0     9      0 J1640+3946               15840  [0,1,2,3,4,5,6,7]  [2, 2, 2, 2, 2, 2, 2, 2]
...
```
This section is organised as follows:
1. [Writing your own script using the skeleton](#Writing_scripts)
2. Example
3. Time-dependent delay and phase calibration of phase-ref J1640+3946 (step 2)
4. Apply calibration so far, image phase ref (step 3)
5. Flagging (step 4)
6. Time-dependent amplitude calibration of the phase-ref (step 5)
7. Apply all calibration to the phase-ref and check (step 6)
8. Image the calibrated phase-ref (step 7)
9. Apply all calibration to the target (step 9)
10. Split out the target with the phase-reference solutions applied and image (step 10)
11. Self-calibrate target - phase (step 11)
12. Image phase-self-calibrated target (step 12)
13. Self-calibrate target - amplitude (step 13)
14. Image the target with phase and amplitude self-calibration applied (step 14)

## <a name="Writing_scripts">1. Writing your own script using the skeleton</a>

* Open `NME_3C345_skeleton_modified.py` (or whatever you have called it) in a text editor.

For each step we are going to figure out the correct inputs for all the tasks in a step, and then we run that step.

**Important** If you don't understand a task or parameter, use `help <task>` in CASA (and replace `<task>` with the name of the task), as in this example, as needed. You can also try inputs by hand, but don't forget to enter your final version of a task (+inputs) into this script.

To ease you into writing your own scripts, the following section describes an example step:

## <a name="Example"> Example

* Look at step 1 in the script `NME_3C345_skeleton_modified.py` (or whatever you have called it) using gedit or your favourite text editor.

```python
### 1) Inspect data
mystep = 1

if(mystep in thesteps):
    print 'Step ', mystep, step_title[mystep]

# Plot target and phase-ref, phase against time, averaging channels

   plotms() #<< this is empty so you have to fill it in yourself!
```

The main purpose of this step is to confirm that the phase-ref and target have phases which show a similar pattern with time; there may be an offset, but we want to check if the corrections from one will be applicable to the other.

* Firstly, let's examine the possible inputs:

```py
# in CASA
default(plotms)
inp                    # Lists parameters
```
Or:
```python
help(plotms)           # Lists parameters briefly and then repeats with more explanation/examples.
```

You can also view help for most tasks by looking at the CASA documentation:
* [CASA version 4](https://casa.nrao.edu/casa_cookbook.pdf)
* [CASA version 5](https://casa.nrao.edu/casadocs/casa-5.1.2)

You can leave most of the parameters as default, but you do need to set the following:

* visibility MS name,
* the axes to plot,
* and the channels to average.

Which parameters correspond to achieving this and how would we show how phases change with time?

* Enter the required parameters in the script, in the text editor.

In addition we may want to (to speed up plotting & ease of interpretation):
* Plot just the RR,LL correlations (we don't care about polarisation here).
* Plot all the baselines to the reference antenna only (i.e. EF) (we assume that any problems affecting an antenna will affect all its baselines)
* You can assume that all the spw are similar so you only need to plot a single spw.
* For extra convenience, set the `coloraxis` parameter to show just the fields in different colors, and the `iteraxis` so you can scroll through the baselines.

With all the appropriate parameters set, your inputs for step 1 should look something like:

```py
### 1) Inspect data
mystep = 1

if(mystep in thesteps):
    print 'Step ', mystep, step_title[mystep]

# Plot target and phase-ref, phase against time, averaging channels

   plotms(vis=phscal1+'_'+target1+'.ms',
          xaxis='time',
          yaxis='phase',
          spw='1', ## or any other
          correlation='LL,RR',
          iteraxis='baseline')
```
Remember to make the indentations consistent and put a comma after all parameters except the last. When you are happy:

# in CASA
mysteps=[1]
execfile('
You can change the plot interactively once it appears, remember to enter any additional parameters in your script.
