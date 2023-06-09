#include "TFile.h"
#include "TTree.h"
#include <cstdlib>
#include <iostream>   // std::cout
#include <string>

using namespace std;

void plotBias()
{
	gROOT->SetStyle("Plain");   // set plain TStyle
	//gStyle->SetOptStat(111111); // draw statistics on plots,
                            // (0) for no output
	gStyle->SetOptStat(111111);	    
	gStyle->SetOptFit(1111);    // draw fit results on plot,
 	                         // (0) for no ouput
	//gStyle->SetPalette(57);     // set color map
	gStyle->SetOptTitle(0);     // suppress title box

	//bool XSscaled = false;
	//TString signalmodel = "ZprimeZHinc";
	
	bool dogaussfit = true;
	bool XSscaled = false;
	//bool plot2ndplot = false;
	//TString signalmodel = "BulkGWW";
	TString signalmodel = "ZprimeZHinc";
	float mass = 5000;
	//should always change below in the draw function by hand...
	float signalfact = 20; //BulkG: (1.4 TeV) 0.3, 0.7; (2 TeV) 0.8, 2; (3 TeV) 4, 11        and (from 4 TeV onward, with workspace with scaling with factor 100): 0.6, 2, 4.6  ||  "ZprimeZHinc" (3 TeV) 0.3, 0.9; (4 TeV) 1.2, 3.6; (5 TeV) 6, 20
	TString signalfactstring = "20"; //BulkG: "0p3", "0p7", "0p8", "2", "4", "11"       and (from 4 TeV onward, with workspace with scaling with factor 100): "0p6", "2", "4p6"  ||  "ZprimeZHinc" 0p3, 0p9, etc
	TString cat = "VBF_VVVH";
	//TString cat = "VVVH";
	//this string is the real signal strength, as if it were never rescaled in the workspace
	//TString xtitle = "(r-3.5)/(0.5*(rHiErr+rLoErr))"; // BulkG: 1.5, 3.5, 4, 10, 20, 55 and (from 4 TeV onward, with workspace with scaling with factor 100): "60", "200", "460" ||  "ZprimeZHinc" same as above, because no scaling
	TString xtitle = "(r-20)/((r<20)*rHiErr+(r>20)*rLoErr)"; //pullv2 ~example online: ((r<inject)*rHiErr+(r>inject)*rLoErr)
	//TString xtitle = "(r-1.5)/((r>1.5)*rHiErr+(r<1.5)*rLoErr)"; //pullv3: ((r>inject)*rHiErr+(r<inject)*rLoErr)
	
	//TString xtitle = "r/(0.5*(rHiErr+rLoErr))"; 
	//TString xtitle = "r/((r<0)*rHiErr+(r>0)*rLoErr)";//pullv2
	//TString xtitle = "r/((r>0)*rHiErr+(r<0)*rLoErr)"; //pullv3

	TString signalsigmainjected = "5#sigma exp. signif. injected"; //"2#sigma exp. signif. injected", "5#sigma exp. signif. injected", "No signal injected", "#approx 5#sigma exp. signif. injected", "r = 1 injected"
	
	TString customplotlabel = ""; //"All nuisances frozen", "Top p_{T} nuisance frozen", "Lumi #times 10 (bkg and sig)", "Lumi #times 10 (bkg)", "Constraint r #geq 0"
	TString customplotlabel2 = "r > lower fit range boundary"; //"(...) \n r > lower fit range boundary

	
	//TString customjobstring="noVBF_nojesjernorm_"; //to agree with the variable in the job submission script
	//TString customjobstring="newfittemplTT_";
	//TString customjobstring="newfittemplTT_toysNoSystematics_";
	//TString customjobstring="newfittemplTT_topptfrozen_toysNoSystematics_";
	//TString customjobstring="newfittemplTT_taggerPtDependencefrozen_toysNoSystematics_";
	//TString customjobstring="newfittemplTT_taggerPTtest2_toysNoSystematics_";
	//TString customjobstring="newfittemplTT_taggerPTtest2_toysNoSystematics_";
	//TString customjobstring="newfittemplTT_taggerPTtest2true_toysNoSystematics_";
	//TString customjobstring="preappbaseline_PDF_toysNoSystematics_";
	//TString customjobstring="preappbaseline_PDF_VjetsShapeFrozen_toysNoSystematics_";
	//TString customjobstring="preappbaseline_PDF_nonResShapeFrozen_toysNoSystematics_";
	//TString customjobstring="preappbaseline_PDF_JesJerFrozen_toysNoSystematics_";
	//TString customjobstring="preappbaseline_PDF_JesFrozen_toysNoSystematics_";
	//TString customjobstring="afterpreapproval_toysNoSystematics_";
	//TString customjobstring="preappbaseline_PDF_allFrozen_toysNoSystematics_";
	//TString customjobstring="preappbaseline_PDF_topptFrozen_toysNoSystematics_";
	TString customjobstring="afterpreapproval_newShapesFits_toysNoSystematics_";
	
	//TString customjobstring="afterpreapproval_newShapes_SigFactor5_lumi1_toysNoSystematics_";
	//TString customjobstring="afterpreapproval_newShapes_SigFactor50_lumi10_toysNoSystematics_";
	//TString customjobstring="afterpreapproval_newShapes_SigFactor5_lumi10_toysNoSystematics_";
	//TString customjobstring="afterpreapproval_saveToys_saveWorkspace_newShapesFits_SigFactor500_lumi100_toysNoSystematics_";
	
	//TString customjobstring="afterpreapproval_newShapes_SigFactor5_lumi1_largerange_toysNoSystematics_";
	//TString customjobstring="afterpreapproval_newShapes_SigFactor50_lumi10_largerange_toysNoSystematics_";
	//TString customjobstring="afterpreapproval_newShapes_SigFactor5_lumi10_largerange_toysNoSystematics_";	
	
	//TString customjobstring="afterpreapproval_newShapes_SigFactor5_lumi1_r0-20_toysNoSystematics_";
	//TString customjobstring="afterpreapproval_allFrozen_saveToys_saveWorkspace_newShapes_SigFactor5_lumi1_toysNoSystematics_";
	
	//TString customjobstring="noVBFcat_afterpreapproval_newShapesFits_factor5_toysNoSystematics_";
	
	//TString customjobstring="afterpreapproval_newShapesFits_factor100_toysNoSystematics_";
	
	
	
	int nbinsplot = 30; //30 or 60
	float plotrangemin = -5; //-5 or -10
	float plotrangemax = 5; //5 or 10
	
	TLatex Tl;
   	Tl.SetTextAlign(12);
   	Tl.SetTextSize(0.035);

	TString filename;
	if(XSscaled)
	{
		filename = customjobstring+"FitDiagnostics_XSscaled_"+signalmodel+"_M"+TString(std::to_string(int(mass)))+"_"+cat+"_signalfact"+TString(signalfactstring)+"/fitDiagnostics_"+signalmodel+"_M"+TString(std::to_string(int(mass)))+"_"+cat+"_merged.root";
	}
	else
	{
		filename = customjobstring+"FitDiagnostics_"+signalmodel+"_M"+TString(std::to_string(int(mass)))+"_"+cat+"_signalfact"+TString(signalfactstring)+"/fitDiagnostics_"+signalmodel+"_M"+TString(std::to_string(int(mass)))+"_"+cat+"_merged.root";
	}
	
	TCanvas* c1 = new TCanvas("bias","bias",800,700);
	TCanvas* c2 = new TCanvas("bias2","bias2",800,700);
	TFile* file = new TFile(filename,"READ");
	
	if( file->IsOpen() )
	{
	
		TTree* tree_fit_sb = (TTree*) file->Get("tree_fit_sb");
		//tree_fit_sb->Draw("(r-0.3)/(0.5*(rHiErr+rLoErr))","fit_status>-1");
		
		TH1F* histpull = new TH1F("histpull","histpull",nbinsplot,plotrangemin,plotrangemax);  //30,-5,5  //60,-10,10
		TH1F* histpull2 = new TH1F("histpull2","histpull2",nbinsplot,plotrangemin,plotrangemax);  //30,-5,5  //60,-10,10


		//this is the best definition:
		tree_fit_sb->Draw("(r-20)/((r<20)*rHiErr+(r>20)*rLoErr)>>histpull","(fit_status>-1)"); //pullv2 ~example online
		tree_fit_sb->Draw("(r-20)/((r<20)*rHiErr+(r>20)*rLoErr)>>histpull2","(fit_status>-1)*(r>-24)"); //pullv2 ~example online

		//tree_fit_sb->Draw("r/((r<0)*rHiErr+(r>0)*rLoErr)>>histpull","(fit_status>-1)"); //pullv2 ~example online
		//tree_fit_sb->Draw("r/((r<0)*rHiErr+(r>0)*rLoErr)>>histpull2","(fit_status>-1)*(r>-24)"); //pullv2 ~example online				


		////OLD:
		//tree_fit_sb->Draw("(r-0.3)/(0.5*(rHiErr+rLoErr))>>histpull","fit_status>-1");
		//tree_fit_sb->Draw("(r-0.3)/(0.5*(rHiErr+rLoErr))>>histpull","(fit_status>-1)*(rErr<20)*(rErr>-20)");
		//tree_fit_sb->Draw("(r-11)/(0.5*(rHiErr+rLoErr))>>histpull","(fit_status>-1)*(rErr<20)*(rErr>-20)");
		//tree_fit_sb->Draw("(r-4)/(0.5*(rHiErr+rLoErr))>>histpull","(fit_status>-1)*(rErr<30)*(rErr>-15)");
		
		//tree_fit_sb->Draw("(r-0.7)/(0.5*(rHiErr+rLoErr))>>histpull","(fit_status>-1)");
		//tree_fit_sb->Draw("(r-0.3)/((r>0.3)*rHiErr+(r<0.3)*rLoErr)>>histpull","(fit_status>-1)"); //pullv3, ~Andreas?				
	
		//tree_fit_sb->Draw("r/(0.5*(rHiErr+rLoErr))>>histpull","(fit_status>-1)");
		//tree_fit_sb->Draw("r/((r<0)*rHiErr+(r>0)*rLoErr)>>histpull","(fit_status>-1)"); //pullv2 ~example online
		//tree_fit_sb->Draw("r/((r>0)*rHiErr+(r<0)*rLoErr)>>histpull","(fit_status>-1)"); //pullv3, ~Andreas? => should not be
		//tree_fit_sb->Draw("r/((r<0)*rHiErr+(r>0)*rLoErr)>>histpull","(fit_status>-1)*(rLoErr<15)*(rHiErr<15)"); //pullv2 ~example online

		//tree_fit_sb->Draw("(r-0.2)/((r<0.2)*rHiErr+(r>0.2)*rLoErr)>>histpull2","(fit_status>-1)*(r>-24)"); //pullv2 ~example online
		//tree_fit_sb->Draw("r/((r<0)*rHiErr+(r>0)*rLoErr)>>histpull2","(fit_status>-1)*(r>-24)"); //pullv2 ~example online

		//tree_fit_sb->Draw("(r-0.24)/((r<0.24)*rHiErr+(r>0.24)*rLoErr)>>histpull","(fit_status>-1)*(rLoErr<25)*(rHiErr<25)"); //pullv2 ~example online
		//tree_fit_sb->Draw("(r-0.24)/((r<0.24)*rHiErr+(r>0.24)*rLoErr)>>histpull","(fit_status==0)"); //pullv2 ~example online

		
		//TLegend* leg = new TLegend(0.15,0.65,0.4,0.88);
		TLegend* leg = new TLegend(0.6,0.6,0.88,0.88);
		leg->SetBorderSize(0);
		
		c1->cd();
		histpull->Draw();
		histpull->GetYaxis()->SetTitleOffset(1.2);
		histpull->GetYaxis()->SetTitle("Number of toys");
		histpull->GetXaxis()->SetTitle(xtitle);
		histpull->SetLineColor(kBlue);
		histpull->SetLineWidth(2);
	
		TF1 *gaussian = new TF1("gaussian","gaus",-3,3);
		gaussian->SetLineColor(kRed);
		if(dogaussfit) histpull->Fit("gaussian","R");
		
		if(signalmodel == "BulkGWW")
		{
			Tl.DrawLatexNDC(0.13,0.86,"BulkG #rightarrow WW ("+TString(std::to_string(int(mass)))+" GeV)");
			
		}
		else if(signalmodel == "ZprimeZHinc")
		{
			Tl.DrawLatexNDC(0.13,0.86,"Z' #rightarrow ZH ("+TString(std::to_string(int(mass)))+" GeV)");
		}
		
		Tl.DrawLatexNDC(0.13,0.81,signalsigmainjected);
		Tl.DrawLatexNDC(0.13,0.76,customplotlabel);
		

		c2->cd();
		histpull2->Draw();
		histpull2->GetYaxis()->SetTitleOffset(1.2);
		histpull2->GetYaxis()->SetTitle("Number of toys");
		histpull2->GetXaxis()->SetTitle(xtitle);
		histpull2->SetLineColor(kBlue);
		histpull2->SetLineWidth(2);
	
		TF1 *gaussian2 = new TF1("gaussian2","gaus",-3,3);
		gaussian2->SetLineColor(kRed);
		if(dogaussfit) histpull2->Fit("gaussian","R");
		
		if(signalmodel == "BulkGWW")
		{
			Tl.DrawLatexNDC(0.13,0.86,"BulkG #rightarrow WW ("+TString(std::to_string(int(mass)))+" GeV)");
			
		}
		else if(signalmodel == "ZprimeZHinc")
		{
			Tl.DrawLatexNDC(0.13,0.86,"Z' #rightarrow ZH ("+TString(std::to_string(int(mass)))+" GeV)");
		}	

		Tl.DrawLatexNDC(0.13,0.81,signalsigmainjected);
		Tl.DrawLatexNDC(0.13,0.76,customplotlabel2);
	
		
		//TString outname = "pulls/"+customjobstring+"bias_pull_"+signalmodel+"_M"+TString(std::to_string(int(mass)))+"_"+cat+"_signalfact"+signalfactstring;
		TString outname = "pullsv2/"+customjobstring+"bias_pullv2_"+signalmodel+"_M"+TString(std::to_string(int(mass)))+"_"+cat+"_signalfact"+signalfactstring; //"pullv2_rErrNotBoundary", "pullv2_rNotBoundary"
		//TString outname = "pullsv3/"+customjobstring+"bias_pullv3_"+signalmodel+"_M"+TString(std::to_string(int(mass)))+"_"+cat+"_signalfact"+signalfactstring;
		//TString outname = "pullsv2/"+customjobstring+"bias_pullv2_fitStatus0_"+signalmodel+"_M"+TString(std::to_string(int(mass)))+"_"+cat+"_signalfact"+signalfactstring;	
		//TString outname = "pullsv2/"+customjobstring+"bias_pullv2_rNotBoundary_"+signalmodel+"_M"+TString(std::to_string(int(mass)))+"_"+cat+"_signalfact"+signalfactstring; //"pullv2_rErrNotBoundary", "pullv2_rNotBoundary"
		//TString outname = "pullsv2/"+customjobstring+"bias_pullv2_r0-20_"+signalmodel+"_M"+TString(std::to_string(int(mass)))+"_"+cat+"_signalfact"+signalfactstring; //"pullv2_rErrNotBoundary", "pullv2_rNotBoundary"
		//TString outname = "pullsv3/"+customjobstring+"bias_pullv3_r0-20_"+signalmodel+"_M"+TString(std::to_string(int(mass)))+"_"+cat+"_signalfact"+signalfactstring; //"pullv2_rErrNotBoundary", "pullv2_rNotBoundary"

		TString outname2 = "pullsv2/"+customjobstring+"bias_pullv2_rNotBoundary_"+signalmodel+"_M"+TString(std::to_string(int(mass)))+"_"+cat+"_signalfact"+signalfactstring; //"pullv2_rErrNotBoundary", "pullv2_rNotBoundary"
		
		c1->SaveAs(outname+".pdf");
		c1->SaveAs(outname+".png");
		
		c2->SaveAs(outname2+".pdf");
		c2->SaveAs(outname2+".png");		

		
	
	}

}


