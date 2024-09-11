
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:mantled_app/model/AssetDocumentModel.dart';
import 'package:mantled_app/model/CollabModel.dart';
import 'package:mantled_app/model/CollaboratorListModel.dart';
import 'package:mantled_app/model/FinancialAssetList.dart';
import 'package:mantled_app/model/IndividualAssetListModel.dart';
import 'package:mantled_app/model/IntangibleAssetsList.dart';
import 'package:mantled_app/model/PersonalPropertyList.dart';
import 'package:mantled_app/model/addbeneficiaryModel.dart';
import 'package:mantled_app/model/allpropetiesModel.dart';
import 'package:mantled_app/model/assetDetailModel.dart';
import 'package:mantled_app/model/assetOverviewModel.dart';
import 'package:mantled_app/model/collaboratorModel.dart';
import 'package:mantled_app/model/editAssetModel.dart';
import 'package:mantled_app/model/lawyer_model.dart';
import 'package:mantled_app/model/linkedInvitesList.dart';
import 'package:mantled_app/model/pendingInvitesModel.dart';
import 'package:mantled_app/model/profileDetails.dart';
import 'package:mantled_app/networking/rest_data.dart';
import 'package:nb_utils/nb_utils.dart';

class Data extends ChangeNotifier{

  List<HousePropertyList> housePropertyList = [];
  List<PendingInvites> pendingInvitesList = [];
  List<LinkedInvitesList> linkedInvitesList = [];
  List<AddBeneficiary> beneficiariesList = [];
  List<AddBeneficiary> assetDetailsBeneficiaryList = [];
  List<AssetDetailModel> assetDetailsAssetsList = [];

  List<AssetDetailModel> cashPersonalAssetList = [];
  List<AssetDetailModel> cryptoPersonalAssetList = [];
  List<AssetDetailModel> pensionPersonalAssetList = [];
  List<AssetDetailModel> insurancePersonalAssetList = [];


  List<AssetDetailModel> personalAssetList = [];
  List<AssetDetailModel> realEstateAssetList = [];

  List<dynamic> assetDocuments=[];
  List<dynamic> assetFinancialDocuments=[];

  List<CollabModel> collaborators=[];

  List<CollabModel> financialCollaborator=[];

  List<PersonalPropertyList> personalPropertyList = [];
  List<IntangibleAssetsList> intangibleAssetList = [];
  List<FinancialAssetList> financialPropertyList = [];
  List<IndividualAssetListModel> collabAssetList = [];

  List<CollaboratorListModel> personalAssetCollabList = [];

  ProfileDetails profileDetails = ProfileDetails();
  EditAssetModel assetDetails = EditAssetModel();

  AssetOverviewModel assetOverview = AssetOverviewModel();
  LawyerModel lawyerDetails = LawyerModel();

Future fetchProfileDetails(context) async{
  profileDetails = await RestDataSource().getProfileDetails(context);
  notifyListeners();
}


  Future fetchPersonalAssetCollabList(context, assetType) async{
    personalAssetCollabList = await RestDataSource().getPersonalAssetCollaborators(context, assetType);
    notifyListeners();
  }

  Future fetchPersonalAssetList(context,  assetType) async{

    personalAssetList = await RestDataSource().getPersonalAssets(context,assetType);
    notifyListeners();
  }

  Future fetchRealEstateAssetsList(context,  assetType) async{
    personalAssetList = await RestDataSource().getRealEstateAssets(context,assetType);
    notifyListeners();
  }




  Future fetchInsurancePersonalAssetList(context,  assetType) async{

    insurancePersonalAssetList = await RestDataSource().getFinancialPersonalAssets(context,assetType);
    notifyListeners();
  }

  Future fetchCryptoPersonalAssetList(context,  assetType) async{

    cryptoPersonalAssetList = await RestDataSource().getFinancialPersonalAssets(context,assetType);
    notifyListeners();
  }

  Future fetchPensionPersonalAssetList(context,  assetType) async{

    pensionPersonalAssetList = await RestDataSource().getFinancialPersonalAssets(context,assetType);
    notifyListeners();
  }


  Future fetchCashPersonalAssetList(context,  assetType) async{

    cashPersonalAssetList = await RestDataSource().getFinancialPersonalAssets(context,"cash");
    notifyListeners();
  }

  Future fetchAssetDocumentList(context, assetID, assetType) async{
    assetDocuments = await RestDataSource().getAssetDocumentList(context, assetID,assetType );
    notifyListeners();
  }

  Future fetchFinancialDocumentList(context, assetID, assetType) async{
    assetFinancialDocuments = await RestDataSource().getFinancialDocumentList(context, assetID,assetType );
    notifyListeners();
  }

  // Future fetchCollabAssetDocumentList(context, assetID) async{
  //   assetDocuments = await RestDataSource().getAssetCollabDocumentList(context, assetID);
  //   notifyListeners();
  // }

  Future fetchAssetCollabList(context,  assetID, assetType) async{
  print(assetID);
    collaborators = await RestDataSource().getCollabList(context,assetID,assetType);
    notifyListeners();
  }



  Future fetchAFinancialAssetCollabList(context,  assetID, assetType) async{
    print(assetID);
    financialCollaborator = await RestDataSource().getFinancialCollabList(context,assetID,assetType);
    notifyListeners();
  }


  Future fetchBeneficiaries(context) async{
    beneficiariesList = await RestDataSource().getBeneficiaryList(context);
    notifyListeners();
  }


  Future fetchPendingInvites(context) async{
    pendingInvitesList = await RestDataSource().getPendingInvites(context);
    notifyListeners();
  }


  Future fetchCollabAssets(context, userID) async{
    collabAssetList = await RestDataSource().getCollabAssets(context, userID);
    notifyListeners();
  }



  Future fetchAssetDetailsAssets(context, userID, assetType) async{
    assetDetailsAssetsList = await RestDataSource().getAssetDetailsAssets(context, userID, assetType);
    notifyListeners();
  }


  Future fetchAssetDetails(context, assetID, assetType) async{
    assetDetails = await RestDataSource().getAssetDetails(context,assetID, assetType);
    notifyListeners();
  }

  Future fetchAssetDetailsBeneficiary(context, userID, assetType) async{
    assetDetailsBeneficiaryList = await RestDataSource().getAssetDetailsBeneficiary(context, userID, assetType);
    notifyListeners();
  }

  Future fetchLinkedInvites(context) async{
    linkedInvitesList = await RestDataSource().getLinkedInvites(context);
    notifyListeners();
  }

  Future fetchAssetOverview(context) async{
    assetOverview = await RestDataSource().getAssetOverview(context);
    notifyListeners();
  }


Future fetchLawyerDetails(context) async{
  lawyerDetails = await RestDataSource().getLawyerDetails(context);
  notifyListeners();
}

  // Future fetchHousingProperties(context) async{
  //   housePropertyList = await  RestDataSource().getHousingProperties(context);
  //   notifyListeners();
  // }
  // Future fetchPersonalProperties(context) async{
  //   personalPropertyList = await RestDataSource().getPersonalAssets(context);
  //   notifyListeners();
  // }
  // Future fetchIntangibleAssets(context) async{
  //   intangibleAssetList = await RestDataSource().getIntangibleAssets(context);
  //   notifyListeners();
  // }
  // Future fetchFinancialProperty(context) async{
  //   financialPropertyList = await RestDataSource().getFinancialAssets(context);
  //   notifyListeners();
  // }


}