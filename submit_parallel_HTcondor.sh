#!/bin/bash

### generic settings 
RESUBMIT=true

workspaces=/afs/cern.ch/work/i/izoi/public/forGerrit/non-VBF_signals/data/AllCat/
echo "workspaces = "$workspaces

outbasedir=/eos/cms/store/cmst3/user/gvonsem/3Ddiboson/toysSignificance/afterpreapproval/

##mode: FitDiagnostics for bias tests; Significance for significances; FitDiagnosticsAsimov for one signal injection for Asimov
#scan significances first, for G bulk -> WW signal (with mass 1.4 TeV, 2 TeV, and 3 TeV) and a Z' -> ZH signal (with mass 3 TeV, 4 TeV, and 5 TeV) [see AN]
mode=FitDiagnostics
#mode=Significance
#mode=FitDiagnosticsAsimov
#mode=toysCLs
#mode=toysSignificance

signalmodel=BulkGWW
####signalmodel=ZprimeZH
#signalmodel=ZprimeZHinc
#signalmodel=WprimeWZ
mass=3000
#cat=VVVH
cat=VBF_VVVH

#fitrangeMin=-25
#fitrangeMax=25

##for BulkG 3000 GeV
fitrangeMin=-15
fitrangeMax=35
##for BulkG 4000 GeV with r=0 injected (test)
#fitrangeMin=-50
#fitrangeMax=25
#fitrangeMin=0
#fitrangeMax=20
##for Z'->ZH 5000 GeV
#fitrangeMin=-15
#fitrangeMax=50

##testing for W'->WZ excess, significance calculation. Actually may not be used by default? Trying to add to command...
#fitrangeMin=0
#fitrangeMax=100


##For significance
#ntoys=3
#niterations=2
ntoys=3
niterations=1
##For CLs
####ntoys=50
####niterations=2


customjobstring="afterpreapproval_newShapesFits_"

###BulkGWW
customworkspacestring="_afterpreapproval_newShapesFits"

workspacename=workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_pseudodata${customworkspacestring}.root
#workspacename=workspace_JJ_${signalmodel}_${cat}_13TeV_Run2_data${customworkspacestring}.root

#XS5=false
XSscaled=false
if [[ $signalmodel == "BulkGWW" || $signalmodel == "BulkGZZ" || $signalmodel == "RadionWW" || $signalmodel == "RadionZZ" ]]; then
	#this needs to be cross checked; make sure you know which workspaces have the scaling x 5
	XSscaled=true
	#customworkspacestring="_newbaseline_noVBF_nojesjernorm_factor5"
fi

echo "XSscaled: "$XSscaled

##flavours:
#"espresso" = 20min
#"microcentury" = 1h
#"longlunch" = 2h
#"workday" = 8h
#"tomorrow" = 1d
#"testmatch" = 3d
#"nextweek" = 1w

if [[ $mode == "FitDiagnostics" ]]; then

	NJOBS=200
	#jobflavour=tomorrow
	jobflavour=testmatch

	##inject signals corresponding to 2 and 5 sigma expected; obtained from first running the significance mode of this script
	##when bulkgww is scaled by factor 5
	if [[ $signalmodel == "BulkGWW" && $mass == 1400 ]]; then
		#signalfact=( 0 )
		#signalfact=( 0.3 0.7 )
		#signalfact=( 0 0.3 0.7 )
		signalfact=( 0.3 )
	elif [[ $signalmodel == "BulkGWW" && $mass == 1500 ]]; then
		###not calculated explicitly what 2 and 5 sigma is. 
		###Will assume XSscaled signal strength of 1 for the 5 sigma, based on the scan of significance vs signal strength
		signalfact=( 1 )		
	elif [[ $signalmodel == "BulkGWW" && $mass == 2000 ]]; then
		#signalfact=( 0 )
		#signalfact=( 0.8 2)
		signalfact=( 0 0.8 2)	
	elif [[ $signalmodel == "BulkGWW" && $mass == 3000 ]]; then
		signalfact=( 0 )
		#signalfact=( 4 11 )
		#signalfact=( 0 4 11 )
	elif [[ $signalmodel == "BulkGWW" && $mass == 4000 ]]; then
		#signalfact=( 0 )
		#signalfact=( 0.2 0.4 )
		signalfact=( 0.2 )
		##when bulkgww is scaled by factor 100
		#signalfact=( 0.6 2 )
	elif [[ $signalmodel == "BulkGWW" && $mass == 5000 ]]; then
		signalfact=( 0 )
		#signalfact=( 0.2 0.4 )
		#signalfact=( 0.2 )
		##when bulkgww is scaled by factor 100 (only the 2sigma is known)
		#signalfact=( 4.6 )
	elif [[ $signalmodel == "BulkGWW" && $mass == 6000 ]]; then
		signalfact=( 0 )
		#signalfact=( 0.2 0.4 )			
	##when bulkgww is scaled by factor 100
#	if [[ $signalmodel == "BulkGWW" && $mass == 1400 ]]; then
#		signalfact=( 0.015 0.035 )
#	elif [[ $signalmodel == "BulkGWW" && $mass == 2000 ]]; then
#		signalfact=( 0.04 0.1 )	
#	elif [[ $signalmodel == "BulkGWW" && $mass == 3000 ]]; then
#		signalfact=( 0.2 0.55 )
	elif [[ $signalmodel == "ZprimeZHinc" && $mass == 1400 ]]; then
		#signalfact=( 0 )
		signalfact=( 0.07 0.24 )
		#signalfact=( 0 0.07 0.24 )				
	elif [[ $signalmodel == "ZprimeZHinc" && $mass == 3000 ]]; then
		#signalfact=( 0 )
		#signalfact=( 0.3 0.9 )
		signalfact=( 0 0.3 0.9 )
	elif [[ $signalmodel == "ZprimeZHinc" && $mass == 4000 ]]; then
		#signalfact=( 0 )
		#signalfact=( 1.2 3.6 )	
		signalfact=( 0 1.2 3.6 )
	elif [[ $signalmodel == "ZprimeZHinc" && $mass == 5000 ]]; then
		#signalfact=( 0 )
		#signalfact=( 6 20 )
		signalfact=( 0 6 20 )
	fi

	##OUTPUTTAG=( ${mode}_${signalmodel}_M${mass}_${cat}_signalfact${signalfact} )
elif [[ $mode == "FitDiagnosticsAsimov" ]]; then
	NJOBS=1
	jobflavour=tomorrow
	##inject signals corresponding to 2 and 5 sigma expected; obtained from first running the significance mode of this script
	##when bulkgww is scaled by factor 5
	if [[ $signalmodel == "BulkGWW" && $mass == 1400 ]]; then
		#signalfact=( 0 )
		signalfact=( 0.3 0.7 )
	elif [[ $signalmodel == "BulkGWW" && $mass == 2000 ]]; then
		#signalfact=( 0 )
		signalfact=( 0.8 2 )	
	elif [[ $signalmodel == "BulkGWW" && $mass == 3000 ]]; then
		#signalfact=( 0 )
		signalfact=( 4 11 )
	elif [[ $signalmodel == "BulkGWW" && $mass == 4000 ]]; then
		signalfact=( 0 )	
	##when bulkgww is scaled by factor 100
#	if [[ $signalmodel == "BulkGWW" && $mass == 1400 ]]; then
#		signalfact=( 0.015 0.035 )
#	elif [[ $signalmodel == "BulkGWW" && $mass == 2000 ]]; then
#		signalfact=( 0.04 0.1 )	
#	elif [[ $signalmodel == "BulkGWW" && $mass == 3000 ]]; then
#		signalfact=( 0.2 0.55 )					
	elif [[ $signalmodel == "ZprimeZHinc" && $mass == 3000 ]]; then
		signalfact=( 0.3 0.9 )
	elif [[ $signalmodel == "ZprimeZHinc" && $mass == 4000 ]]; then
		signalfact=( 1.2 3.6 )	
	elif [[ $signalmodel == "ZprimeZHinc" && $mass == 5000 ]]; then
		signalfact=( 6 20 )
	fi	
	
elif [[ $mode == "Significance" ]]; then
	NJOBS=1     #per signalfact
	#jobflavour=longlunch
	#jobflavour=tomorrow
	jobflavour=testmatch
	#jobflavour=nextweek
	#signalfact=( 1 5 10 15 20 25 30 35 40 45 50 55 60 65 70 75 80 85 90 95 100 150 200 250 300 350 400 450 500 750 1000 )
	signalfact=( 1 5 10 15 20 25 30 35 40 45 50 )
	#signalfact=( 0.2 0.4 0.6 0.8 )
	#signalfact=( 0.2 )

	##using workspace with factor 5 already in the input cross sections
	##actually may also be good for Z'->ZH?
	#signalfact=( 0.2 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 )	
	#signalfact=( 7 8 )
	#signalfact=( 5 10 20 30 40 50 60 70 80 90 100 )	
	##or using workspace with factor 100 already in the input cross sections
	#signalfact=( 0.25 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 )
	
	##using workspace with factor 10 already in the input cross sections -> this was not the case, it was scaled by 100
	##signalfact=( 0.1 0.5 1 2 3 4 5 6 7 8 9 10 )
	
	##BulkGWW, using workspace with factor 100 already in the input cross sections	
	#signalfact=( 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 )	
	
	##For Z'->ZHinc, not scaled with factor 10
	#signalfact=( 0.2 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 )
	##for 1400 GeV mass point
	#signalfact=( 0.05 0.1 0.15 0.2 0.25 0.3 0.35 0.4 0.45 0.5 )

elif [[ $mode == "toysCLs" ]]; then
	NJOBS=50     #per signalfact
	#NJOBS=1     #per signalfact
	
	#jobflavour=longlunch
	jobflavour=tomorrow
	#jobflavour=testmatch
	#jobflavour=nextweek
	
	#signalfact=( 10 )
	#signalfact=( 6 8 12 14 )
	if [[ $signalmodel == "BulkGWW" && $mass == 4000 ]]; then
		#assumes a scaling with a factor 10
		signalfact=( 6 8 10 12 14 )
	elif [[ $signalmodel == "BulkGWW" && $mass == 5000 ]]; then
		##assumes a scaling with a factor 10
		#signalfact=( 50 70 90 110 130)
		##assumes a scaling with a factor 100
		signalfact=( 5 7 9 11 13)
	elif [[ $signalmodel == "BulkGWW" && $mass == 6000 ]]; then
		##assumes a scaling with a factor 100
		#signalfact=( 60 90 120 150 180 )
		##assumes a scaling with a factor 1000
		signalfact=( 6 9 12 15 18 )		
	fi
	
elif [[ $mode == "toysSignificance" ]]; then
	NJOBS=100
	
	##jobflavour=longlunch
	#jobflavour=tomorrow
	jobflavour=testmatch
	##jobflavour=nextweek
	
	#not really relevant
	signalfact=( 1 )
	
fi



i=0
for j in "${signalfact[@]}"
do
	if [ "$XSscaled" = true ]; then
		OUTPUTTAG[$i]=${customjobstring}${mode}_XSscaled_${signalmodel}_M${mass}_${cat}_signalfact${j}
	else 
		OUTPUTTAG[$i]=${customjobstring}${mode}_${signalmodel}_M${mass}_${cat}_signalfact${j}
	fi
	#echo "signalfact: "${j}
	i=$(($i+1))
done



#OUTPUTTAG=( biastest-${signalmodel}_M${mass}-toysFrequentist ) 
#OUTPUTTAG=( biastest_signalfact10_${signalmodel}_M${mass}-toysFrequentist ) 
#OUTPUTTAG=( biastest_WithoutNoErrors_${signalmodel}_M${mass}-toysFrequentist ) 
#OUTPUTTAG=( biastest_WithoutNoErrorsWithMinos_${signalmodel}_M${mass}_${cat}_signalfact${signalfact}-toysFrequentist ) 
#OUTPUTTAG=( ${mode}_${signalmodel}_M${mass}_${cat}_signalfact${signalfact} ) 

# for j in "${OUTPUTTAG[@]}"
# do
# 	echo ${j}
# done		



### start job submission 
JOBID=`echo "scale=0; ${#OUTPUTTAG[@]} -1 " | bc` 
for IJOBID in `seq 0 ${JOBID}`; do

    TAG=${OUTPUTTAG[${IJOBID}]} ;
    #replace . with p for folders
    TAG=${TAG/./p}

    echo $TAG
    #echo "IJOBID = "$IJOBID
    #ls -A ${outbasedir}/${TAG}
	#if [ ! "$(ls -A ${outbasedir}/${TAG})" ] | [ $RESUBMIT = false ];
	if [ ! "$(ls -A ${outbasedir}/${TAG})" ];
	then
		if [[ $RESUBMIT ]];
		then
			echo "  Job did not succeed, will resubmit"
		fi

	    #mkdir -p ${outbasedir}/HTcondorLogs/${TAG}/
	    mkdir -p HTcondorLogs/${TAG}/
	    

		cp Job_base.sh Job_base_${TAG}.sh
		sed -i -e "s|SUBMODE|${mode}|g" Job_base_${TAG}.sh
		sed -i -e "s|SUBWORKSPACES|${workspaces}|g" Job_base_${TAG}.sh
		sed -i -e "s|SUBOUTBASEDIR|${outbasedir}|g" Job_base_${TAG}.sh
		sed -i -e "s|SUBOUTFOLDER|${TAG}|g" Job_base_${TAG}.sh	
		sed -i -e "s|SUBSIGNALMODEL|${signalmodel}|g" Job_base_${TAG}.sh
		sed -i -e "s|SUBMASS|${mass}|g" Job_base_${TAG}.sh
		sed -i -e "s|SUBCAT|${cat}|g" Job_base_${TAG}.sh
		sed -i -e "s|SUBSIGNALFACT|${signalfact[$IJOBID]}|g" Job_base_${TAG}.sh
		sed -i -e "s|SUBWORKSPACENAME|${workspacename}|g" Job_base_${TAG}.sh
		sed -i -e "s|SUBFITRANGEMIN|${fitrangeMin}|g" Job_base_${TAG}.sh
		sed -i -e "s|SUBFITRANGEMAX|${fitrangeMax}|g" Job_base_${TAG}.sh
		sed -i -e "s|SUBNTOYS|${ntoys}|g" Job_base_${TAG}.sh
		sed -i -e "s|SUBNITERATIONS|${niterations}|g" Job_base_${TAG}.sh

		cp submit_parallel.sub submit_parallel_${TAG}.sub
		sed -i -e "s|SUBNAME|${TAG}|g" submit_parallel_${TAG}.sub
		sed -i -e "s|SUBBASESCRIPT|Job_base_${TAG}.sh|g" submit_parallel_${TAG}.sub
		sed -i -e "s|SUBOUTBASEDIR|${outbasedir}|g" submit_parallel_${TAG}.sub	
		sed -i -e "s|SUBJOBFLAVOUR|${jobflavour}|g" submit_parallel_${TAG}.sub
		sed -i -e "s|SUBQUEUE|${NJOBS}|g" submit_parallel_${TAG}.sub

		condor_submit submit_parallel_${TAG}.sub
		sleep 2s
	else
		echo "  Job succeeded, will not resubmit"
	fi

done

