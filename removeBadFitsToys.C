#include "TFile.h"
#include "TTree.h"
#include <cstdlib>

using namespace std;

void removeBadFitsToys(TString filepath,TString filename)
{
	//TString filepath = "/eos/cms/store/cmst3/user/gvonsem/3Ddiboson/biastests/BulkGWW_M2000_VVVH_trial4/";	
	//TString filename = "fitDiagnostics_BulkGWW_M2000_VVVH_00007.root";
	TFile* _file0 = TFile::Open(filepath+filename);
	
	std::cout << "file: " << filepath+filename << std::endl;
	if(_file0)
	{
		TTree* sbtree= (TTree*) _file0->Get("tree_fit_sb");
		int nentries = sbtree->GetEntriesFast();
		Double_t r;
		Int_t fit_status;
  		sbtree->SetBranchAddress("r",&r);
	  	sbtree->SetBranchAddress("fit_status",&fit_status);

		//std::cout << " number of entries of tree: " << nentries << std::endl;
	
		for(int i=0; i<nentries; i++)
		{
			sbtree->GetEntry(i);
			//cout<<" r = "<<r<<endl;
			//cout<<" fit_status = "<<fit_status<<endl;
			if(fit_status < 0)
			{
				TString newfilename = filename+"_fitfailed";
				std::cout << "    ==> fit failed for entry " << i << " of file " << filename << " --> renaming file to " << newfilename << std::endl;
				system("mv "+filepath+filename+" "+filepath+newfilename);
				break;
			}
		}
	}
	else std::cout << "File not found" << std::endl;
	
	//return 0;
}
