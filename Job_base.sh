#!/bin/sh

echo -e "\nJob started at "`date`" on "`hostname --fqdn`"\n"

# set job id (zero padded)
ID="$(printf '%05d' "${JOB_PROC_ID}")"

echo "JOB_PROC_ID = "${JOB_PROC_ID}

echo 'WORKDIR ' ${PWD}
source /afs/cern.ch/cms/cmsset_default.sh
cd /afs/cern.ch/work/g/gvonsem/public/Diboson/biastests/CMSSW_10_2_10/src/
cmsenv

echo $CMSSW_BASE

#ls -lrth


# change back to the directory
echo "tmp dir condor = "${_CONDOR_SCRATCH_DIR}
cd ${_CONDOR_SCRATCH_DIR}
#pwd

#echo "printing environment"
#printenv

## execute scripts
echo "Run Combine"

mode=SUBMODE
workspaces=SUBWORKSPACES
outbasedir=SUBOUTBASEDIR
outfolder=SUBOUTFOLDER
signalmodel=SUBSIGNALMODEL
mass=SUBMASS
cat=SUBCAT
signalfact=SUBSIGNALFACT
workspacename=SUBWORKSPACENAME
#fitrangeMin=SUBFITRANGEMIN
#fitrangeMax=SUBFITRANGEMAX
ntoys=SUBNTOYS
niterations=SUBNITERATIONS


echo "mode "${mode}", signal model "${signalmodel}", mass: "M${mass}", cat: "${cat}", factor: "${signalfact}", ID: "${ID} 

#outputdir=${outbasedir}/${signalmodel}_M${mass}_${cat}_signalfact${signalfact}_WithoutNoErrorsWithMinos_toysFrequentist_noSaveToys/
outputdir=${outbasedir}/${outfolder}/
mkdir -p $outputdir

#combine -M FitDiagnostics ${workspaces}/workspace_JJ_BulkGWW_VV_HPHP_13TeV_Run2_pseudodata.root -m 2000 --saveToys --noErrors --minos none --rMin -10 --rMax 10 --expectSignal=1 -t 10 -s ${ID} -n _BulkGWW_M2000_VV_HPHP_${ID}
#combine -M FitDiagnostics ${workspaces}/workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_pseudodata.root -m ${mass} --toysFrequentist --noErrors --minos none --rMin -15 --rMax 15 --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_signalfact${signalfact}_${ID}
#combine -M FitDiagnostics ${workspaces}/workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_pseudodata.root -m ${mass} --toysFrequentist --noErrors --minos none --rMin -30 --rMax 30 --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
#combine -M FitDiagnostics ${workspaces}/workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_pseudodata.root -m ${mass} --toysFrequentist --minos none --rMin -15 --rMax 15 --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}

if [[ $mode == "FitDiagnostics" ]]; then

	#outputfile=fitDiagnostics_BulkGWW_M2000_VVVH_${ID}.root
	outputfile=fitDiagnostics_${signalmodel}_M${mass}_${cat}_${ID}.root
	#combine -M FitDiagnostics ${workspaces}/workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_pseudodata.root -m ${mass} --toysFrequentist --rMin -15 --rMax 15 --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M FitDiagnostics ${workspaces}/workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_pseudodata_all.root -m ${mass} --toysFrequentist --rMin -20 --rMax 20 --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	
	#combine -M FitDiagnostics ${workspaces}/workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_pseudodata_newbaseline.root -m ${mass} --toysFrequentist --rMin -20 --rMax 20 --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M FitDiagnostics ${workspaces}/workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_pseudodata_newbaseline_fixedTagger.root -m ${mass} --toysFrequentist --rMin -20 --rMax 20 --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M FitDiagnostics ${workspaces}/workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_pseudodata_newbaseline_fixedTagger.root -m ${mass} --toysFrequentist --rMin -15 --rMax 45 --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}

	#combine -M FitDiagnostics ${workspaces}/workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_pseudodata_newbaseline_NOJMR1sigma_factor5.root -m ${mass} --toysFrequentist --rMin -20 --rMax 20 --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M FitDiagnostics ${workspaces}/workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_pseudodata_newbaseline_NOJMR1sigma_factor5.root -m ${mass} --toysFrequentist --rMin -15 --rMax 30 --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M FitDiagnostics ${workspaces}/workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_pseudodata_newbaseline_NOJMR1sigma.root -m ${mass} --toysFrequentist --rMin -20 --rMax 20 --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M FitDiagnostics ${workspaces}/workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_pseudodata_newbaseline_NOJMR1sigma.root -m ${mass} --toysFrequentist --rMin -15 --rMax 50 --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}

	#combine -M FitDiagnostics ${workspaces}/workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_pseudodata_newbaseline_NOJMR1sigma_VjetsShapes_factor5.root -m ${mass} --toysFrequentist --rMin -25 --rMax 25 --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M FitDiagnostics ${workspaces}/workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_pseudodata_newbaseline_NOJMR1sigma_VjetsShapes_factor5.root -m ${mass} --toysFrequentist --rMin -15 --rMax 35 --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M FitDiagnostics ${workspaces}/workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_pseudodata_newbaseline_noVBF_nojesjernorm_factor5.root -m ${mass} --toysFrequentist --rMin -15 --rMax 35 --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M FitDiagnostics ${workspaces}/workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_pseudodata_newbaseline_noVBF_nojesjernorm_factor5.root -m ${mass} --toysFrequentist --rMin -25 --rMax 25 --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}

	#combine -M FitDiagnostics ${workspaces}/${workspacename} -m ${mass} --toysFrequentist --rMin -15 --rMax 35 --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M FitDiagnostics ${workspaces}/${workspacename} -m ${mass} --toysFrequentist --rMin SUBFITRANGEMIN --rMax SUBFITRANGEMAX --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M FitDiagnostics ${workspaces}/${workspacename} -m ${mass} --rMin SUBFITRANGEMIN --rMax SUBFITRANGEMAX --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}

	combine -M FitDiagnostics ${workspaces}/${workspacename} -m ${mass} --toysNoSystematics --rMin SUBFITRANGEMIN --rMax SUBFITRANGEMAX --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	######combine -M FitDiagnostics ${workspaces}/${workspacename} -m ${mass} --toysNoSystematics --freezeParameters var{CMS_VV_JJ_TTJets_TOPPT*} --rMin SUBFITRANGEMIN --rMax SUBFITRANGEMAX --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	##combine -M FitDiagnostics ${workspaces}/${workspacename} -m ${mass} --toysNoSystematics --freezeParameters CMS_tagger_PtDependence --rMin SUBFITRANGEMIN --rMax SUBFITRANGEMAX --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M FitDiagnostics ${workspaces}/${workspacename} -m ${mass} --toysNoSystematics --freezeParameters var{CMS_VV_JJ_Wjets_PTZ_.*},var{CMS_VV_JJ_Wjets_OPTZ_.*},var{CMS_VV_JJ_Zjets_PTZ_.*},var{CMS_VV_JJ_Zjets_OPTZ_.*} --rMin SUBFITRANGEMIN --rMax SUBFITRANGEMAX --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M FitDiagnostics ${workspaces}/${workspacename} -m ${mass} --toysNoSystematics --freezeParameters var{CMS_VV_JJ_nonRes_PT_.*},var{CMS_VV_JJ_nonRes_OPT_.*},var{CMS_VV_JJ_nonRes_TurnOn_.*},var{CMS_VV_JJ_nonRes_altshape2_.*},var{CMS_VV_JJ_nonRes_altshape_.*} --rMin SUBFITRANGEMIN --rMax SUBFITRANGEMAX --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M FitDiagnostics ${workspaces}/${workspacename} -m ${mass} --toysNoSystematics --freezeParameters CMS_jes_scale_j,CMS_jer_res_j --rMin SUBFITRANGEMIN --rMax SUBFITRANGEMAX --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M FitDiagnostics ${workspaces}/${workspacename} -m ${mass} --toysNoSystematics --freezeParameters var{CMS_.*} --rMin SUBFITRANGEMIN --rMax SUBFITRANGEMAX --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M FitDiagnostics ${workspaces}/${workspacename} -m ${mass} --toysNoSystematics --freezeParameters var{CMS_VV_JJ_TTJets_TOPPT.*} --rMin SUBFITRANGEMIN --rMax SUBFITRANGEMAX --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M FitDiagnostics ${workspaces}/${workspacename} -m ${mass} --toysNoSystematics --freezeParameters CMS_jes_scale_j --rMin SUBFITRANGEMIN --rMax SUBFITRANGEMAX --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	
	#combine -M FitDiagnostics ${workspaces}/${workspacename} -m ${mass} --toysNoSystematics --saveToys --rMin SUBFITRANGEMIN --rMax SUBFITRANGEMAX --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M FitDiagnostics ${workspaces}/${workspacename} -m ${mass} --toysNoSystematics --robustFit 1 --saveToys --rMin SUBFITRANGEMIN --rMax SUBFITRANGEMAX --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M FitDiagnostics ${workspaces}/${workspacename} -m ${mass} --toysNoSystematics --saveToys --saveWorkspace --rMin SUBFITRANGEMIN --rMax SUBFITRANGEMAX --expectSignal=${signalfact} -t 1 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M FitDiagnostics ${workspaces}/${workspacename} -m ${mass} --toysNoSystematics --freezeParameters var{CMS_.*} --saveToys --saveWorkspace --rMin SUBFITRANGEMIN --rMax SUBFITRANGEMAX --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M FitDiagnostics ${workspaces}/${workspacename} -m ${mass} --toysNoSystematics --freezeParameters var{CMS_.*} --saveToys --saveWorkspace --rMin SUBFITRANGEMIN --rMax SUBFITRANGEMAX --expectSignal=${signalfact} -t 1 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M FitDiagnostics ${workspaces}/${workspacename} -m ${mass} --toysNoSystematics --saveToys --rMin SUBFITRANGEMIN --rMax SUBFITRANGEMAX --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M FitDiagnostics ${workspaces}/${workspacename} -m ${mass} --toysNoSystematics --saveToys --setParameters r=1 --rMin SUBFITRANGEMIN --rMax SUBFITRANGEMAX --expectSignal=${signalfact} -t ${ntoys} -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}


	#combine -M FitDiagnostics ${workspaces}/${workspacename} -m ${mass} --toysFrequentist --rMin SUBFITRANGEMIN --rMax SUBFITRANGEMAX --expectSignal=${signalfact} -t 3 -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}



	##optional: remove other stuff in the root file, only retain trees of the toy fit results 
	##hadding of many files may give (size?) problems otherwise. If not done here, there is still a script retainTrees.sh to do it afterwards
	rootrm -r ${outputfile}:nuisances_prefit_res
	rootrm -r ${outputfile}:ProcessID0
	rootrm -r ${outputfile}:nuisances_prefit
	rootrm -r ${outputfile}:fit_b
	rootrm -r ${outputfile}:fit_s

	# copy output
	#cp fitDiagnostics_BulkGWW_M2000_VV_HPHP_${ID}.root /eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/BulkGWW_M2000_VV_HPHP
	#cp fitDiagnostics_BulkGWW_M2000_VV_HPLP_${ID}.root /eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/BulkGWW_M2000_VV_HPLP
	#cp fitDiagnostics_BulkGWW_M2000_VV_HPHP_${ID}.root /eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/BulkGWW_M2000_VV_HPHP_signal5injected
	#cp fitDiagnostics_BulkGWW_M3000_VV_HPHP_${ID}.root /eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/BulkGWW_M3000_VV_HPHP
	#cp fitDiagnostics_BulkGWW_M2000_VVVH_${ID}.root /eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/BulkGWW_M2000_VVVH_trial4
	#cp fitDiagnostics_BulkGWW_M2000_VVVH_${ID}.root /eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/BulkGWW_M2000_VVVH_trial5_toysFrequentist
	#cp fitDiagnostics_BulkGWW_M2000_VVVH_${ID}.root /eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/BulkGWW_M2000_VVVH_trial6_toysFrequentist
	#cp ${outputfile} /eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/BulkGWW_M2000_VVVH_trial7_toysFrequentist_noSaveToys
	#cp ${outputfile} $outputdir
	cp *.root $outputdir
	
elif [[ $mode == "FitDiagnosticsAsimov" ]]; then
	outputfile=fitDiagnostics_${signalmodel}_M${mass}_${cat}_bkgsigAsimov.root
	#combine -M FitDiagnostics ${workspaces}/workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_pseudodata_newbaseline_noVBF_nojesjernorm_factor5.root -m ${mass} --toysFrequentist --rMin -15 --rMax 35 --expectSignal=${signalfact} -t -1 -n _${signalmodel}_M${mass}_${cat}_bkgsigAsimov
	#combine -M FitDiagnostics ${workspaces}/${workspacename} -m ${mass} --toysFrequentist --rMin -15 --rMax 35 --expectSignal=${signalfact} -t -1 -n _${signalmodel}_M${mass}_${cat}_bkgsigAsimov
	#combine -M FitDiagnostics ${workspaces}/${workspacename} -m ${mass} --toysFrequentist --rMin SUBFITRANGEMIN --rMax SUBFITRANGEMAX --expectSignal=${signalfact} -t -1 -n _${signalmodel}_M${mass}_${cat}_bkgsigAsimov
	combine -M FitDiagnostics ${workspaces}/${workspacename} -m ${mass} --toysNoSystematics --rMin SUBFITRANGEMIN --rMax SUBFITRANGEMAX --expectSignal=${signalfact} -t -1 -n _${signalmodel}_M${mass}_${cat}_bkgsigAsimov

	cp ${outputfile} $outputdir

elif [[ $mode == "Significance" ]]; then
	
	#combine -M Significance ${workspaces}/workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_pseudodata.root -m ${mass} -t -1 --expectSignal=${signalfact} -n _${signalmodel}_M${mass}_${cat}
	##combine -M Significance ${workspaces}/workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_data.root -m ${mass} -t -1 --expectSignal=${signalfact} -n _${signalmodel}_M${mass}_${cat}
	#combine -M Significance ${workspaces}/workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_pseudodata_all.root -m ${mass} -t -1 --expectSignal=${signalfact} -n _${signalmodel}_M${mass}_${cat}
	#combine -M Significance ${workspaces}/workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_pseudodata_newbaseline.root -m ${mass} -t -1 --expectSignal=${signalfact} -n _${signalmodel}_M${mass}_${cat}
	#combine -M Significance ${workspaces}/workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_pseudodata_newbaseline_fixedTagger.root -m ${mass} -t -1 --expectSignal=${signalfact} -n _${signalmodel}_M${mass}_${cat}
	
	combine -M Significance ${workspaces}/${workspacename} -m ${mass} -t -1 --expectSignal=${signalfact} -n _${signalmodel}_M${mass}_${cat}

	cp *.root $outputdir

elif [[ $mode == "toysCLs" ]]; then
	
	combine -M HybridNew ${workspaces}/${workspacename} -m ${mass} --LHCmode LHC-limits --singlePoint ${signalfact} --cminDefaultMinimizerStrategy=0 --saveToys --saveHybridResult -T ${ntoys} --clsAcc 0 --iterations ${niterations} -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}

	cp *.root $outputdir
	
elif [[ $mode == "toysSignificance" ]]; then
	
	#combine -M HybridNew ${workspaces}/${workspacename} -m ${mass} --LHCmode LHC-significance --saveToys --fullBToys --saveHybridResult --pvalue -T ${ntoys} -i ${niterations} -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	#combine -M HybridNew ${workspaces}/${workspacename} -m ${mass} --LHCmode LHC-significance --saveToys --fullBToys --saveHybridResult -T ${ntoys} -i ${niterations} -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}
	combine -M HybridNew ${workspaces}/${workspacename} -m ${mass} --rMin SUBFITRANGEMIN --rMax SUBFITRANGEMAX --LHCmode LHC-significance --saveToys --fullBToys --saveHybridResult -T ${ntoys} -i ${niterations} -s ${ID} -n _${signalmodel}_M${mass}_${cat}_${ID}

	cp *.root $outputdir	
		
fi



#done 
echo -e "\nJob stopped at "`date`" on "`hostname --fqdn`"\n"

exit 0
