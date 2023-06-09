
NJOBS=300
#NJOBS=2

for IJOBID in `seq 1 ${NJOBS}`; do

   ID="$(printf '%05d' "${IJOBID}")"

   #filepath=/eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/BulkGWW_M2000_VVVH_trial4/
   #filepath=/eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/BulkGWW_M2000_VVVH_trial6_toysFrequentist/
   #filepath=/eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/BulkGWW_M2000_VVVH_trial7_toysFrequentist_noSaveToys/
   #filepath=/eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/afterpreapproval/afterpreapproval_newShapesFits_toysNoSystematics_FitDiagnostics_XSscaled_BulkGWW_M1400_VBF_VVVH_signalfact0p7/
   filepath=/eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/afterpreapproval/afterpreapproval_newShapesFits_factor100_toysNoSystematics_FitDiagnostics_XSscaled_BulkGWW_M5000_VBF_VVVH_signalfact4p6/
   filename=fitDiagnostics_BulkGWW_M5000_VBF_VVVH_${ID}.root
   echo $filename
   rootrm -r ${filepath}/${filename}:nuisances_prefit_res
   rootrm -r ${filepath}/${filename}:ProcessID0
   rootrm -r ${filepath}/${filename}:nuisances_prefit
   rootrm -r ${filepath}/${filename}:fit_b
   rootrm -r ${filepath}/${filename}:fit_s

done

