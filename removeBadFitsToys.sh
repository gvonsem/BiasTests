
NJOBS=300
#NJOBS=2

for IJOBID in `seq 1 ${NJOBS}`; do

   ID="$(printf '%05d' "${IJOBID}")"

   #filepath=/eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/BulkGWW_M2000_VVVH_trial4/
   #filepath=/eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/BulkGWW_M2000_VVVH_trial6_toysFrequentist/
   #filepath=/eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/BulkGWW_M2000_VVVH_trial7_toysFrequentist_noSaveToys/
   #filepath=/eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/ggDYonlyCat/BadFitsRemoved_noVBF_nojesjernorm_FitDiagnostics_XSscaled_BulkGWW_M3000_VVVH_signalfact4/
   #filepath=/eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/newfittemplTT/BadFitsRemoved_newfittemplTT_toysNoSystematics_FitDiagnostics_XSscaled_BulkGWW_M3000_VBF_VVVH_signalfact4/
   #filepath=/eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/newfittemplTT/BadFitsRemoved_newfittemplTT_toysNoSystematics_FitDiagnostics_XSscaled_BulkGWW_M3000_VBF_VVVH_signalfact11/
   #filepath=/eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/preappbaseline_PDF/BadFitsRemoved_preappbaseline_PDF_toysNoSystematics_FitDiagnostics_XSscaled_BulkGWW_M3000_VBF_VVVH_signalfact0/
   #filepath=/eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/preappbaseline_PDF/BadFitsRemoved_preappbaseline_PDF_toysNoSystematics_FitDiagnostics_XSscaled_BulkGWW_M1400_VBF_VVVH_signalfact0/
   #filepath=/eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/preappbaseline_PDF/BadFitsRemoved_preappbaseline_PDF_toysNoSystematics_FitDiagnostics_XSscaled_BulkGWW_M3000_VBF_VVVH_signalfact11/
   filepath=/eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/preappbaseline_PDF/BadFitsRemoved_preappbaseline_PDF_toysNoSystematics_FitDiagnostics_XSscaled_BulkGWW_M1400_VBF_VVVH_signalfact0p7/


   filename=fitDiagnostics_BulkGWW_M1400_VBF_VVVH_${ID}.root
   echo $filename
   rootcommand="removeBadFitsToys.C(\"${filepath}\",\"${filename}\")"
   echo $rootcommand
   ##root -b -q -l 'removeBadFitsToys.C("fitDiagnostics_BulkGWW_M2000_VVVH_00007.root")'        #OK
   ##root -b -q -l 'removeBadFitsToys.C("fitDiagnostics_BulkGWW_M2000_VVVH_${ID}.root")'        #NOT OK
   ##root -b -q -l 'removeBadFitsToys.C(${filename})'        #NOT OK
   root -b -q -l $rootcommand

done

