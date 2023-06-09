#include "TFile.h"
#include "TTree.h"
#include <cstdlib>
#include <iostream>   // std::cout
#include <string>

using namespace std;

//void plotGOF(TString filepath,TString filenametoys,TString filenamedata)
void plotSignificance()
{
	gROOT->SetStyle("Plain");   // set plain TStyle
	//gStyle->SetOptStat(111111); // draw statistics on plots,
                            // (0) for no output
	gStyle->SetOptFit(1111);    // draw fit results on plot,
 	                         // (0) for no ouput
	//gStyle->SetPalette(57);     // set color map
	gStyle->SetOptTitle(0);     // suppress title box


	//TFile* _filetoys = TFile::Open(filepath+"/"+filenametoys);
	//TFile* _filedata = TFile::Open(filepath+"/"+filenamedata);

	//TString basepath = "/eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/";
	TString basepath = "/eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/afterpreapproval/";
	//TString customjobstring="afterpreapproval_toysNoSystematics_";
	//TString customjobstring="afterpreapproval_newShapes_SigFactor5_lumi1_toysNoSystematics_";
	TString customjobstring="afterpreapproval_newShapesFits_factor100_toysNoSystematics_";

	bool XSscaled = true; //if input XS in used workspaces is already scaled with factor 10 or not
	TString signalmodel = "BulkGWW";
	//TString signalmodel = "ZprimeZHinc";
	
	////TString mass = "2000";
	const int nmasses = 3; //3
	////for "BulkGWW"
	//float masses[nmasses] = {1400,2000,3000};
	//const int nmasses = 1;	
	//float masses[nmasses] = {3000};
	//const int nmasses = 2;	
	//float masses[nmasses] = {1400,2000};
	float masses[nmasses] = {4000,5000,6000};

	////for "ZprimeZHinc"
	//float masses[nmasses] = {3000,4000,5000};
	//float masses[nmasses] = {1400};

	int massindex_start = 0; //0 for all masses, 1 if you want to skip 1st mass; But may need some hack in the drawing of the axes of the traph


	//TString cat = "VVVH";
	TString cat = "VBF_VVVH";
	//int nsignalfacts = 31;
	//float signalfact[31] = {1,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,150,200,250,300,350,400,450,500,750,1000};
	//const int nsignalfacts = 30;
	//float signalfact[nsignalfacts] = {1,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100,150,200,250,300,350,400,450,500,1000};	
	
	////const int nsignalfacts = 9;
	////float signalfact[nsignalfacts] = {1,5,10,15,20,25,30,35,40};
	
	////fine for most
	//const int nsignalfacts = 9;
	//float signalfact[nsignalfacts] = {1,5,10,15,20,25,30,35,40};
	//TString signalfactstring[nsignalfacts] = {"1","5","10","15","20","25","30","35","40"};

	//const int nsignalfacts = 13;
	//float signalfact[nsignalfacts] = {0.2,0.4,0.6,0.8,1,5,10,15,20,25,30,35,40};
	//TString signalfactstring[nsignalfacts] = {"0p2","0p4","0p6","0p8","1","5","10","15","20","25","30","35","40"};

	////the scan I used when input is already scaled with a factor 5
	//or in a second iteration I used the same steps for ZprimeToZH
	//const int nsignalfacts = 16;
	//float signalfact[nsignalfacts] = {0.2,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
	//TString signalfactstring[nsignalfacts] = {"0p2","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"};
	
	
	////BulkGWW, when already scaled with a factor 10
	//const int nsignalfacts = 10;
	//float signalfact[nsignalfacts] = {0.1,0.5,1,2,3,4,5,6,7,8};
	//TString signalfactstring[nsignalfacts] = {"0p1","0p5","1","2","3","4","5","6","7","8"};
	////BulkGWW higher masses, when already scaled with a factor 5
	const int nsignalfacts = 11;
	float signalfact[nsignalfacts] = {0.25,0.5,1,1.5,2,2.5,3,3.5,4,4.5,5};
	TString signalfactstring[nsignalfacts] = {"0p25","0p5","1","1p5","2","2p5","3","3p5","4","4p5","5"};
	

	////ZprimeZHinc, workspace not scaled with any factor a priori
	//const int nsignalfacts = 21;
	//float signalfact[nsignalfacts] = {0.2,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20};
	//TString signalfactstring[nsignalfacts] = {"0p2","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"};		
	
	////ZprimeZHinc 1.4 TeV, workspace not scaled with any factor a priori
	//const int nsignalfacts = 10;
	//float signalfact[nsignalfacts] = {0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45,0.5};
	//TString signalfactstring[nsignalfacts] = {"0p05","0p1","0p15","0p2","0p25","0p3","0p35","0p4","0p45","0p5"};	
		
	
	
	
	
	float signalfactAxis[nsignalfacts];
	
	//const int nsignalfacts = 21; //22??
	//float signalfact[nsignalfacts] = {0.1,0.5,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20};




	////fine for most
	float plotxrange = 21;
	float plotyrange = 15;
	
	////for ZprimeZHinc at 1.4 TeV
	//float plotxrange = 0.35;
	//float plotyrange = 15;	

    	for(int j = 0; j < nsignalfacts; j++)
	{
		if(XSscaled) signalfactAxis[j] = signalfact[j] * 100; //5, 10, 100
		else signalfactAxis[j] = signalfact[j];
	}

	//if(XSscaled) plotxrange = 71;
	if(XSscaled) plotxrange = 510;


	////for the scan I used when input is already scaled with a factor 5
	//float plotxrange = 12;
	//float plotyrange = 10;


	//for ZprimeZH 3000 GeV
	//float plotxrange = 1.4;
	//float plotyrange = 10;

	float plotxrangesigmaline = plotxrange;
	//float plotxrangesigmaline = 1.75;
	
	
	TCanvas* c1 = new TCanvas("Significance","Significance",800,600);
	//TLegend* leg = new TLegend(0.15,0.65,0.4,0.88);
	TLegend* leg = new TLegend(0.6,0.6,0.88,0.88);
	leg->SetBorderSize(0);



	for(int k = massindex_start; k < nmasses; k++)
	{
	  std::cout << "mass : " << masses[k] << std::endl;
	  float significances[nsignalfacts];
	  for(int j = 0; j < nsignalfacts; j++)
	  {

		//TString filename = "Significance_"+signalmodel+"_M"+TString(std::to_string(int(masses[k])))+"_"+cat+"_signalfact"+TString(std::to_string(int(signalfact[j])))+"/higgsCombine_"+signalmodel+"_M"+TString(std::to_string(int(masses[k])))+"_"+cat+".Significance.mH"+TString(std::to_string(int(masses[k])))+".root";
		TString filename;

		if(XSscaled)
		{
			filename = customjobstring+"Significance_XSscaled_"+signalmodel+"_M"+TString(std::to_string(int(masses[k])))+"_"+cat+"_signalfact"+TString(signalfactstring[j])+"/higgsCombine_"+signalmodel+"_M"+TString(std::to_string(int(masses[k])))+"_"+cat+".Significance.mH"+TString(std::to_string(int(masses[k])))+".root";
		}
		else
		{
			filename = customjobstring+"Significance_"+signalmodel+"_M"+TString(std::to_string(int(masses[k])))+"_"+cat+"_signalfact"+TString(signalfactstring[j])+"/higgsCombine_"+signalmodel+"_M"+TString(std::to_string(int(masses[k])))+"_"+cat+".Significance.mH"+TString(std::to_string(int(masses[k])))+".root";
		}
		//filename = "Significance_XSscaled_"+signalmodel+"_M"+TString(std::to_string(int(masses[k])))+"_"+cat+"_signalfact"+TString(std::to_string(int(signalfact[j])))+"/higgsCombine_"+signalmodel+"_M"+TString(std::to_string(int(masses[k])))+"_"+cat+".Significance.mH"+TString(std::to_string(int(masses[k])))+".root";
		TFile* file = new TFile(basepath+filename,"READ");

		std::cout << " file: " << basepath+filename << std::endl;
	
		Double_t significance = -99;
		if( file->IsOpen() )
		{
			//c1->cd();
			//c1->Draw("limit");

			//TH1F* histpull = new TH1F("histpull","histpull",50,-5,5);

			TTree* tree = (TTree*) file->Get("limit");
			
			tree->SetBranchAddress("limit",&significance);
			tree->GetEntry(0);



			// TTree* tree_fit_sb = (TTree*) _filetoys->Get("tree_fit_sb");
			// tree_fit_sb->Draw("(r-1)/(0.5*(rHiErr+rLoErr))>>histpull");
			// histpull->GetXaxis()->SetTitle("(r-1)/(0.5*(rHiErr+rLoErr))");
			// //histpull->Rebin(2);
			// histpull->GetYaxis()->SetTitle("Number of toys");
			// histpull->SetLineWidth(2);
			// histpull->SetLineColor(kBlue);		

			// TF1 *fgaus = new TF1("fgaus","gaus",-2,2);
			// fgaus->SetLineColor(kRed);
			// histpull->Fit("fgaus","R");


			// TTree* sbtree= (TTree*) _file0->Get("tree_fit_sb");
			// int nentries = sbtree->GetEntriesFast();
			// Double_t r;
			// Int_t fit_status;
	  // 		sbtree->SetBranchAddress("r",&r);
		 //  	sbtree->SetBranchAddress("fit_status",&fit_status);

			// //std::cout << " number of entries of tree: " << nentries << std::endl;
		
			// for(int i=0; i<nentries; i++)
			// {
			// 	sbtree->GetEntry(i);
			// 	//cout<<" r = "<<r<<endl;
			// 	//cout<<" fit_status = "<<fit_status<<endl;
			// 	if(fit_status < 0)
			// 	{
			// 		TString newfilename = filename+"_fitfailed";
			// 		std::cout << "    ==> fit failed for entry " << i << " of file " << filename << " --> renaming file to " << newfilename << std::endl;
			// 		system("mv "+filepath+filename+" "+filepath+newfilename);
			// 		break;
			// 	}
			// }
		}
		else std::cout << "File not found" << std::endl;
	
		significances[j] = float(significance);
		std::cout << "    significance = " << significance << std::endl;

	  }


	  TGraph* gr = new TGraph(nsignalfacts,signalfactAxis,significances);
	  if(k==0)
	  {
	  	gr->GetXaxis()->SetTitle("Signal strength"); //"Signal strength"; but but when input is already scaled with a factor 5: "Signal strength / 5"
		//gr->GetXaxis()->SetTitle("Signal strength / 5"); //(outdated) "Signal strength"; but when input is already scaled with a factor 5: "Signal strength / 5"
		gr->GetYaxis()->SetTitle("Expected significance");
		gr->SetMarkerStyle(20);
		gr->SetMarkerSize(2);
		gr->SetMarkerColor(kRed); //kRed
		gr->SetLineColor(kRed); //kRed
		//gr->SetMarkerColor(kGreen); //kRed
		//gr->SetLineColor(kGreen); //kRed		
		gr->Draw("APL");	
		gr->GetXaxis()->SetRangeUser(0,plotxrange); //bulkgww: 0,32; but when input is not already scaled with a factor 5: 0,11
		gr->GetYaxis()->SetRangeUser(0,plotyrange); //bulkgww: 0,15; but when input is already scaled with a factor 5: 0,10
	  }
	  else if(k==1)
	  {
	  	gr->GetXaxis()->SetTitle("Signal strength"); //"Signal strength"; but but when input is already scaled with a factor 5: "Signal strength / 5"
		gr->GetYaxis()->SetTitle("Expected significance");
	  	gr->SetMarkerStyle(21);
		gr->SetMarkerSize(2);
		gr->SetMarkerColor(kBlue);
		gr->SetLineColor(kBlue);
		gr->Draw("PL SAME");
	  	//gr->Draw("APL");
	  	gr->GetXaxis()->SetRangeUser(0,plotxrange);
		gr->GetYaxis()->SetRangeUser(0,plotyrange);
	  
	  }
	  else if(k==2)
	  {
	  	gr->GetXaxis()->SetTitle("Signal strength"); //"Signal strength"; but but when input is already scaled with a factor 5: "Signal strength / 5"
		gr->GetYaxis()->SetTitle("Expected significance");
	  	gr->SetMarkerStyle(22);
		gr->SetMarkerSize(2);
		gr->SetMarkerColor(kGreen);
		gr->SetLineColor(kGreen);
	  	gr->Draw("PL SAME");
	  	//gr->Draw("APL");
	  	gr->GetXaxis()->SetRangeUser(0,plotxrange);
		gr->GetYaxis()->SetRangeUser(0,plotyrange);	  	
	  }	  

	  leg->AddEntry(gr,signalmodel+" ("+TString(std::to_string(int(masses[k])))+" GeV)","LP");



	}

	// TGraph* gr = new TGraph(nsignalfacts,signalfact,significances);
	// gr->Draw("APL");
	// gr->GetXaxis()->SetTitle("Signal strength");
	// gr->GetYaxis()->SetTitle("Expected significance");
	// gr->SetMarkerStyle(20);
	// gr->SetMarkerSize(2);
	// gr->SetMarkerColor(kRed);

	// TLegend* leg = new TLegend(0.7,0.1,0.9,0.3);
	// leg->AddEntry("gr","BulkG #rightarrow WW (2000 GeV)","lep");

	leg->Draw("SAME");

	TLine* line2sigma = new TLine(0,2,plotxrangesigmaline,2); //bulkgww: 0,2,32,2; but when input is not already scaled with a factor 5: 0,2,11,2
	line2sigma->SetLineColor(kBlack);
	line2sigma->SetLineWidth(1);
	line2sigma->SetLineStyle(kDashed);
	line2sigma->Draw("SAME");

	TLine* line5sigma = new TLine(0,5,plotxrangesigmaline,5); //bulkgww: 0,2,32,2; but when input is not already scaled with a factor 5: 0,2,11,2
	line5sigma->SetLineColor(kBlack);
	line5sigma->SetLineWidth(1);
	line5sigma->SetLineStyle(kDashed);
	line5sigma->Draw("SAME");

	//return 0;
}
