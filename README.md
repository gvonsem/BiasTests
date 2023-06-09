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
This `submit_parallel_HTcondor.sh` script creates jobs that will run (on condor) a script that is a modified version of the `Job_base.sh` template script.

