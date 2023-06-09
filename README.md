# BiasTests
Scattered code for bias tests with Combine. Uses Condor for job submission.

## Installation
First setup CMSSW and install the Combine tool (see recommended versions elsewhere)

```
cmsrel CMSSW_10_2_10
(...)
```


Clone the repository and create a directory for the log files of the condor jobs

```
cd CMSSW_10_2_10/src/HiggsAnalysis/CombinedLimit/test/
git clone https://github.com/gvonsem/BiasTests.git
mkdir HTcondorLogs
```

## Usage
The main script to run is `submit_parallel_HTcondor.sh`. This script needs to be configured by hand according to the use case (input and output paths, running mode, ...). 
The modes are:
- **FitDiagnostics**: main fit mode of Combine, performing a certain amount of toys (hardcoded 3 by default) while injecting signal stengths as specified in the main script and fitting signal strength, to determine if there is a bias
- **Significance**: calculate significance based on a certain injected signal strength
- FitDiagnosticsAsimov: like FitDiagnostics but instead of toys it runs for Asimov data
- toysCLs: full CLs toys for limit calculation (using HybridNew)
- toysSignificance: full CLs toys for significance calculation (using HybridNew)
The mode determines the Combine command that will be run on the condor node.
This `submit_parallel_HTcondor.sh` script creates jobs that will run (on condor) a script that is a modified version of the `Job_base.sh` template script. It will also create a modified version of the template condor job configuration script `submit_parallel.sub`. In `submit_parallel_HTcondor.sh`, don't forget to also choose the appropriate Condor queue (short or long jobs, to be decided based on trial and error).

To know which signal strenghts are relevant to inject (e.g. 2 or 5 standard deviations), one can first determine the significances. Therefore one has to perform a first scan of the injected signal strength and calculated the corresponding significances. Modify `submit_parallel_HTcondor.sh` for the Significance mode and run:
```
./submit_parallel_HTcondor.sh
```

The output root files (one root file per job of X toys) is stored in the output path specified in the script. You can merge the toys root files with hadd, e.g.:
```
hadd -f higgsCombine_WprimeWZ_M2700_VBF_VVVH_merged.HybridNew.mH2700.root /eos/cms/store/cmst3/user/(...)/*root
```
There is an example plotting script to plot the significance as a function of the injected signal strength to determine what is the approximate signal strenght to inject to reach 2 or 5 standard deviations.
```
root -l plotSignificance.C
```

Once the signal strenghts corresponding to 2 and 5 standard deviations have been determined, you can run the actual signal injection toys via the mode FitDiagnostics, so again modifying the script and running:
```
./submit_parallel_HTcondor.sh
```

When the results are ready and again merged via hadd, another script can be used to plot the distribution of fitted signal strength to see if there is any significant bias. 
```
root -l plotBias.C
```

**Note**: there are a few additional helper scripts.
- It may happen that some fits of toys fail. To get rid of such toys, there is a script that can be configured and run `./removeBadFitsToys.sh`. However, it is important to check why the fits fail, because removing failed fits may bias the bias studies themselves.
- The output toy root files may have problems when merging because of additional file content that is not mergable. Normally this content is already remvoved (see the rootrm comands in `Job_base.sh`). If this is not done, it can be redone on the fly using the script `retainTrees.sh` before hadding.





