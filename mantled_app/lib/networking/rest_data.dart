import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
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
import 'package:mantled_app/model/collaboratorModel.dart';
import 'package:mantled_app/model/financialassets.dart';
import 'package:mantled_app/model/housing_property_model.dart';
import 'package:mantled_app/model/lawyer_model.dart';
import 'package:mantled_app/model/linkedInvitesList.dart';
import 'package:mantled_app/model/pendingInvitesModel.dart';
import 'package:mantled_app/model/profileDetails.dart';
import 'package:http/http.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mantled_app/constants/constants.dart';
import 'package:mantled_app/model/complete_profile.dart';
import 'package:mantled_app/model/create_delivery_request.dart';
import 'package:mantled_app/model/delivery_request_details.dart';
import 'package:mantled_app/model/logistics_fares.dart';
import 'package:mantled_app/model/sign_up_user.dart';
import 'package:mantled_app/model/user_code.dart';
import 'package:mantled_app/model/user_info.dart';
import 'package:mantled_app/networking/error-handler.dart';
import 'package:mantled_app/networking/network_util.dart';
import 'package:mantled_app/model/agent_deliveries_details.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'dart:convert';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart' show MediaType;

import '../model/assetOverviewModel.dart';
import '../model/editAssetModel.dart';

/// A [RestDataSource] class to do all the send request to the back end
/// and handle the result
class RestDataSource {
  /// Instantiating a class of the [FutureValues]
  // var futureValue = FutureValues();

  /// Instantiating a class of the [ErrorHandler]
  var errorHandler = ErrorHandler();

  /// Instantiating a class of the [NetworkHelper]
  NetworkHelper _netUtil = NetworkHelper();

  static const GENERATE_CODE = "${TEST_URL}deliveries/generate-code";
  static const CUSTOMER_SIGN_UP = "${BASE_URL}users/signup";
  static const UPDATE_USER = "${BASE_URL}users/updatemyprofile";
  static const VERIFY_USER = "${BASE_URL}users/auth/verifyNumber/";
  static const UPDATE_EMAIL = "${BASE_URL}users/updatemyemail";
  static const UPDATE_PASSWORD = "${BASE_URL}users/auth/updatepassword/";
  static const UPDATE_BENEFICIARY = "${BASE_URL}users/updatemyprofile";
  static const PROVIDER_SIGN_UP = "${BASE_URL}users/signup";
  static const LOGIN_TEST = "${BASE_URL}users/signIn";
  static const ASSET_DOC_UPLOAD = "${BASE_URL}assets/upload";

  static const CREATE_ASSET = "${BASE_URL}documents/housingproperties";

  static const CREATE_TANGIBLE_ASSET = "${BASE_URL}documents/intangibleassets";
  static const CREATE_PERSONAL_ASSET = "${BASE_URL}documents/personaleffects";
  static const CREATE_OTHER_ASSET = "${BASE_URL}documents/memoirs";


  static const CREATE_CASH_ASSET = "${BASE_URL}documents/financialAssets/cash";
  static const CREATE_CRYPTO_ASSET = "${BASE_URL}documents/financialAssets/crypto";
  static const CREATE_PENSION_ASSET = "${BASE_URL}documents/financialAssets/pension";
  static const CREATE_INSURANCE_ASSET = "${BASE_URL}documents/financialAssets/insurance";

  static const CREATE_DEBTS_ASSET = "${BASE_URL}documents/debts-and-liabilities";

  static const CREATE_ASSET_BENEFICIARY = "${BASE_URL}assets/beneficiary";
  static const ADD_ASSET_BENEFICIARY = "${BASE_URL}assets/beneficiary/add";

  static const CREATE_COLLABORATOR = "${BASE_URL}assets/collaborators";
  static const FETCH_ASSET_OVERVIEW = "${BASE_URL}assets/overview";
  static const FETCH_PENDING_INVITES = "${BASE_URL}assets/invite";
  static const FETCH_LINKED_INVITES = "${BASE_URL}assets/linked";
  static const EDIT_LAWYER = "${BASE_URL}lawyers/";
  static const FETCH_BENEFICIARIES = "${BASE_URL}assets/beneficiary";
  static const FETCH_ASSET_DETAILS= "${BASE_URL}assets/collab/asset";

  static const FETCH_COLLABORATORS= "${BASE_URL}assets/collaborators";

  static const PROFILE_DETAILS = "${BASE_URL}users/me";
  static const CREATE_LAWYER = "${BASE_URL}lawyers/";
  static const FETCH_PROFILE = "${BASE_URL}users/me";
  static const FETCH_LAWYER_DETAILS = "${BASE_URL}lawyers/";




  // static const CUSTOMER_LOGIN = "${BASE_URL}users/login?role=customer";
  // static const AGENT_LOGIN = "${TEST_URL}users/login?role=agent";
  // static const CREATE_HOUSING_PROPERTY = "${BASE_URL}documents/housingproperties";
  // static const DELETE_HOUSING_PROPERTY="${BASE_URL}documents/housingproperties";
  // static const DELETE_PERSONAL_PROPERTY="${BASE_URL}documents/personaleffects";
  // static const DELETE_FINANCIAL_PROPERTY="${BASE_URL}documents/financialAssets";
  // static const DELETE_INTANGIBLE_PROPERTY="${BASE_URL}documents/intangibleassets";
  // static const CREATE_FINANCIAL_ASSETS = "${BASE_URL}documents/financialAssets";
  // static const CREATE_INTANGIBLE_ASSETS = "${BASE_URL}documents/intangibleassets";
  // static const FETCH_DELIVERY_REQUESTS = "${TEST_URL}deliveries";
  // static const CREATE_PERSONAL_EFFECTS = "${BASE_URL}documents/personaleffects";
  // static const UPDATE_DELIVERY_REQUESTS = "${BASE_URL}deliveries/2";
  // static const FETCH_LOGISTICS_FARE = "${TEST_URL}fares";
  // static const FETCH_STARTED_DELIVERIES =
  //     "${TEST_URL}deliveries?status=started&limit=30";
  // static const FETCH_PROCESSING_DELIVERIES =
  //     "${TEST_URL}deliveries?status=processing&limit=30";
  // static const PROFILE_DETAILS = "${BASE_URL}users/me";
  // static const CREATE_LAWYER = "${BASE_URL}lawyers/";

  // static const FECTH_HOUSING_PROPERTY = "${BASE_URL}documents/housingproperties";
  // static const FECTH_PERSONAL_ASSETS = "${BASE_URL}documents/personaleffects";
  // static const FECTH_INTANGIBLE_ASSETS= "${BASE_URL}documents/intangibleassets";
  // static const FECTH_FINANCIAL_ASSETS= "${BASE_URL}documents/financialAssets";

  /// A function that creates a new delivery request POST.
  /// with [CreateDeliveryRequest] model
  ///
  Future<dynamic> createAsset(AssetModel assetData) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil.post(CREATE_ASSET,
        encoding: Encoding.getByName("utf-8"),
        headers: header,
        body: {
          "assetName": assetData.propTitle,
          "propertyAddress":{
            "address": "${assetData.propAddressOne!} ${assetData.propAddressTwo!}",
            "lga" : assetData.localGov,
            "state":assetData.stateName,
                "country": assetData.countryName
          },

          "documentType": "Housing Documents",
          "assetType": assetData.assetType!.toUpperCase(),
        }).then((dynamic res) {
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
        return res["data"]['doc']['id'] ;
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<dynamic> createTangibleAsset(AssetModel assetData) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    var map = <String, dynamic>{};
    map['assetName'] = assetData.propTitle;
    map['assetType'] =  assetData.assetType;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil.post(CREATE_TANGIBLE_ASSET,
        encoding: Encoding.getByName("utf-8"),
        headers: header,
        body: map).then((dynamic res) {
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
        return res["data"]['intangibleAsset']['id'] ;
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<dynamic> createPersonalAsset(AssetModel assetData) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';

    return _netUtil.post(CREATE_PERSONAL_ASSET,
        encoding: Encoding.getByName("utf-8"),
        headers: header,
        body: {
          "assetName": assetData.propTitle,
          "assetType": assetData.assetType,

        }).then((dynamic res) {
      Map<String, dynamic> responseArray = res;

      if (responseArray.containsKey('error')) {
        print("THere is a problem");
        throw (res["message"]);
      } else {
        return res["data"]['personalEffects']['id'] ;
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<dynamic> createOthersAsset(AssetModel assetData) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil.post(CREATE_OTHER_ASSET,
        encoding: Encoding.getByName("utf-8"),
        headers: header,
        body: {
          "assetName": assetData.propTitle,

        }).then((dynamic res) {
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
        return res["data"]['memoir']['_id'] ;
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<dynamic> createCashAsset(AssetModel assetData) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil.post(CREATE_CASH_ASSET,
        encoding: Encoding.getByName("utf-8"),
        headers: header,
        body: {
          "assetName": assetData.propTitle,
          "country": assetData.countryName,
          "assetType": assetData.assetType!.toUpperCase(),
          "amount": assetData.valueAmount,
          "financialInstitution": assetData.financialInstitution,
          "accountManager": assetData.accountManager,

        }).then((dynamic res) {
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
        return res["data"]["doc"]['_id'] ;
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }


  Future<dynamic> createCryptoAsset(AssetModel assetData) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil.post(CREATE_CRYPTO_ASSET,
        encoding: Encoding.getByName("utf-8"),
        headers: header,
        body: {
          "assetName": assetData.propTitle,
          "country": assetData.countryName,
          "assetType":"CRYPTO",
          "amount": assetData.amount,
          "cryptoType": assetData.cryptoType,
          "platform": assetData.platformName,

        }).then((dynamic res) {
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
        return res["data"]["doc"]['_id'] ;
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }


  Future<dynamic> pensionAsset(AssetModel assetData) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil.post(CREATE_PENSION_ASSET,
        encoding: Encoding.getByName("utf-8"),
        headers: header,
        body: {
          "assetName": assetData.propTitle,
          "country": assetData.countryName,
          "assetType": "PENSION",
          "amount": assetData.amount,
          "pensionProvider": assetData.pensionProvider,
          "pensionType": assetData.pensionType,

        }).then((dynamic res) {
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
        return res["data"]["doc"]['_id'] ;
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<dynamic> insuranceAsset(AssetModel assetData) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil.post(CREATE_INSURANCE_ASSET,
        encoding: Encoding.getByName("utf-8"),
        headers: header,
        body: {
          "assetName": assetData.propTitle,
          "country": assetData.countryName,
          "assetType": "INSURANCE",
          "amount": assetData.amount,
          "insuranceCompany": assetData.insuranceCompany,
          "insuranceType": assetData.insuranceType,

        }).then((dynamic res) {
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
        return res["data"]["doc"]['_id'] ;
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<dynamic> createDebtsAsset(AssetModel assetData) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    var map = <String, dynamic>{};

    return _netUtil.post(CREATE_DEBTS_ASSET,
        encoding: Encoding.getByName("utf-8"),
        headers: header,
        body: {
          "personOwed": assetData.personOwed,
        "amount" : assetData.valueAmount,
        }).then((dynamic res) {
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
        print("Here is the ID");

        return res["data"]["doc"]['_id'];
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }
  Future<dynamic> editAsset(AssetModel assetData, String assetID) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    var baseUrl= "${BASE_URL}assets/$assetID";

    return _netUtil.patch(baseUrl,
        encoding: Encoding.getByName("utf-8"),
        headers: header,
        body: {
          "name": assetData.propTitle,
          "addressLine1": assetData.propAddressOne,
          "addressLine2": assetData.propAddressTwo,
          "lga": assetData.localGov,
          "state": assetData.stateName,
          "country": assetData.countryName,
          "type": assetData.assetType,
        }).then((dynamic res) {
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
        return res["message"];
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<dynamic> completeProfileDocUpload(
      String baseUrl1,
      String baseUrl2,
      List<File> myFileList,
      ) async {

    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    var uri1 = Uri.parse(baseUrl1);
    var uri2 = Uri.parse(baseUrl2);

    String coverImagePath = myFileList[0].path;
    String identification = myFileList[1].path;

    print("These are the paths");
    print(coverImagePath);
    print(identification);
    var request = http.MultipartRequest("PATCH", uri1);
    var request2 = http.MultipartRequest("PATCH", uri2);
    request.headers.addAll(header);
    request2.headers.addAll(header);
    var multipartFile1 =
    await http.MultipartFile.fromPath("photo", coverImagePath);
    var multipartFile2 =
    await http.MultipartFile.fromPath("governmentID", identification);
    request.files.add(multipartFile1);
    request2.files.add(multipartFile2);
    await request.send().then((response) {
      http.Response.fromStream(response).then((value) async {
        await request2.send().then((response2) {
          http.Response.fromStream(response2).then((value2) {
            print(value2.statusCode);
            print(value2.body);
          });
        });
      });
    });
  }




  // Future<dynamic> uploadAssetDocuments(
  //     List<PlatformFile> fileList, String assetID) async {
  //   Map<String, String> header;
  //   header = {
  //     "Accept": "*/*",
  //     "Content-Type": "multipart/form-data; boundary=<calculated when request is sent>",
  //   };
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
  //   var uri = Uri.parse(ASSET_DOC_UPLOAD);
  //   var request = http.MultipartRequest('POST', uri);
  //   request.headers.addAll(header);
  //   print(assetID);
  //   request.fields['assetId'] = assetID;
  //   List<File> myFileList=[];
  //   for (var i = 0; i < fileList.length; i++) {
  //     final File document = File(fileList[i].path!);
  //     myFileList.add(document);
  //     print(document);
  //   }
  //   print(basename(myFileList[0].path));
  //   print("This is the filename");
  //
  //   if (myFileList.isNotEmpty) {
  //     for (var i = 0; i < myFileList.length; i++) {
  //       request.files.add(
  //           await http.MultipartFile.fromPath(
  //             'C of o Document/${basename(myFileList[i].path)}',
  //             myFileList[i].path,
  //           )
  //       );
  //
  //     }
  //
  //     var response = await request.send();
  //     response.stream.transform(utf8.decoder).listen((value) {
  //       print(response.statusCode);
  //       debugPrint(value);
  //     });
  //     // var streamedResponse = await request.send();
  //     // var response = await http.Response.fromStream(streamedResponse);
  //     // final result = jsonDecode(response.body) as Map<String, dynamic>;
  //     // print(response.statusCode);
  //     if(response.statusCode<200 || response.statusCode>400){
  //       return "Error";
  //     }
  //     return "Asset created successfully";
  //   }
  //
  //
  // }


  // Future createPost(String token,
  //     {required String text, List<File>? images}) async {
  //   var data = <String, dynamic>{};
  //   try {
  //     print(text);
  //     data['text'] = text;
  //     if (images != null && images.isNotEmpty) {
  //       List<MultipartFile> multiPart = [];
  //       for (var image in images) {
  //         multiPart.add(await MultipartFile.fromFile(image.path,
  //             contentType: MediaType.parse("image/jpeg"),
  //             filename:
  //             "post_image${DateTime.now().millisecondsSinceEpoch}.${image.path.split(".").last}"));
  //       }
  //       print(multiPart);
  //       data['image'] = multiPart;
  //     }
  //     return post("posts",
  //         headers: getHeader(token), formData: FormData.fromMap(data));
  //   } catch (err) {
  //     if (err is RequestException) {
  //       throw CustomException(err.message);
  //     }
  //     throw CustomException("Something went wrong");
  //   }
  // }



  Future<dynamic> uploadAssetDocuments(
      List<PlatformFile> fileList, String assetID, String assetCategory) async {
    Map<String, String> header;
    header = {
      "Accept": "*/*",
      "Content-Type": "multipart/form-data; boundary=<calculated when request is sent>",
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    var ASSET_DOC_UPLOAD="";

    if(assetCategory=="real_estate"){
      ASSET_DOC_UPLOAD="${BASE_URL}documents/housingproperties/$assetID";
    }
    else  if(assetCategory=="tangible_assets"){
      ASSET_DOC_UPLOAD="${BASE_URL}documents/intangibleassets/$assetID";
    }
    else  if(assetCategory=="personal_assets"){
      ASSET_DOC_UPLOAD="${BASE_URL}documents/personaleffects/$assetID";
    }
    else  if(assetCategory=="financial_assets_cash"){
      ASSET_DOC_UPLOAD="${BASE_URL}documents/financialAssets/cash/$assetID";
    }
    else  if(assetCategory=="financial_assets_crypto"){
      ASSET_DOC_UPLOAD="${BASE_URL}documents/financialAssets/crypto/$assetID";
    }
    else  if(assetCategory=="financial_assets_pension"){
      ASSET_DOC_UPLOAD="${BASE_URL}documents/financialAssets/pension/$assetID";

    } else  if(assetCategory=="financial_assets_insurance"){
      ASSET_DOC_UPLOAD="${BASE_URL}documents/financialAssets/insurance/$assetID";
    }

    else  if(assetCategory=="debts_and_liabilities"){
      ASSET_DOC_UPLOAD="${BASE_URL}documents/debts-and-liabilities/$assetID";
    }
    else  if(assetCategory=="others"){
      ASSET_DOC_UPLOAD="${BASE_URL}documents/memoirs/$assetID";
    }

    print(ASSET_DOC_UPLOAD);

    var uri = Uri.parse(ASSET_DOC_UPLOAD);

    var request = http.MultipartRequest('PATCH', uri);
    request.headers.addAll(header);
    print(assetID);
    //request.fields['assetId'] = assetID;
    List<File> myFileList=[];
    for (var i = 0; i < fileList.length; i++) {
      final File document = File(fileList[i].path!);
      myFileList.add(document);
      print(document);
    }

    if (myFileList.isNotEmpty) {
      for (var i = 0; i < myFileList.length; i++) {
        print("you have added the file");

        request.files.add(
            http.MultipartFile(
                'assetDocument',
                File(myFileList[i].path).readAsBytes().asStream(),
                File(myFileList[i].path).lengthSync(),
                filename: basename(myFileList[i].path.split("/").last)));

      }

      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
        print(response.statusCode);
        debugPrint(value);
      });
      // var streamedResponse = await request.send();
      // var response = await http.Response.fromStream(streamedResponse);
      // final result = jsonDecode(response.body) as Map<String, dynamic>;
      // print(response.statusCode);
      if(response.statusCode<200 || response.statusCode>400){
        return "Error";
      }
      return "Asset created successfully";
    }


  }


  Future<dynamic> uploadAssetPictures(
      List<File> fileList, String assetID, String assetCategory) async {
    Map<String, String> header;
    header = {
      "Accept": "*/*",
      "Content-Type": "multipart/form-data; boundary=<calculated when request is sent>",
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';


    var ASSET_DOC_UPLOAD="";


      if(assetCategory=="tangible_assets"){
      ASSET_DOC_UPLOAD="${BASE_URL}documents/intangibleassets/$assetID";
    }
    else  if(assetCategory=="personal_assets"){
      ASSET_DOC_UPLOAD="${BASE_URL}documents/personaleffects/$assetID";
    }

    else  if(assetCategory=="others"){
      ASSET_DOC_UPLOAD="${BASE_URL}documents/memoirs/$assetID";
    }

    print("This is for Asset Images");

    var uri = Uri.parse(ASSET_DOC_UPLOAD);
    var request = http.MultipartRequest('PATCH', uri);
    request.headers.addAll(header);

    List<File> myFileList=[];
    for (var i = 0; i < fileList.length; i++) {
      final File document = File(fileList[i].path);
      myFileList.add(document);
      print(document);
    }

    if (myFileList.isNotEmpty) {
      for (var i = 0; i < myFileList.length; i++) {
        print("you have added the file");

        request.files.add(
            http.MultipartFile(
                'assetImage',
                File(myFileList[i].path).readAsBytes().asStream(),
                File(myFileList[i].path).lengthSync(),
                filename: basename(myFileList[i].path.split("/").last)));

      }

      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
        print(response.statusCode);
        print("uploading the file");
        debugPrint(value);
      });
      print(response.statusCode);

      if(response.statusCode<200 || response.statusCode>=400){
        return "Error";
      }
      return "Asset created successfully";
    }


  }

  Future<dynamic> editUploadedDocuments(
      List<PlatformFile> fileList, String assetID) async {
    Map<String, String> header;
    header = {
      "Accept": "*/*",
      "Content-Type": "multipart/form-data; boundary=<calculated when request is sent>",
    };

    String baseURL= "${BASE_URL}assets/upload/$assetID";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    var uri = Uri.parse(baseURL);
    var request = http.MultipartRequest('PATCH', uri);
    request.headers.addAll(header);
    print("Hey gys we here");
    print(assetID);
    request.fields['assetId'] = assetID;
    List<File> myFileList=[];
    for (var i = 0; i < fileList.length; i++) {
      final File document = File(fileList[i].path!);
      myFileList.add(document);
      print(document);
    }

    if (myFileList.isNotEmpty) {
      for (var i = 0; i < myFileList.length; i++) {
        print("you have added the file");

        request.files.add(
            http.MultipartFile(
                'files',
                File(myFileList[i].path).readAsBytes().asStream(),
                File(myFileList[i].path).lengthSync(),
                filename: basename(myFileList[i].path.split("/").last)));

      }

      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) {
        print(response.statusCode);
        debugPrint(value);
      });
      // var streamedResponse = await request.send();
      // var response = await http.Response.fromStream(streamedResponse);
      // final result = jsonDecode(response.body) as Map<String, dynamic>;
      // print(response.statusCode);
      if(response.statusCode<200 || response.statusCode>400){
        return "Error";
      }
      return "Asset created successfully";
    }


  }


  Future<dynamic> deleteDocuments (List<String> deleteList, String assetID) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    String baseURL= "${BASE_URL}assets/document/$assetID";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil.deleteForm(baseURL,
      headers: header,
      body:{
        "documentIds":deleteList
      }
    ).then((dynamic res) async {


    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }



  /// A function that creates a new user POST.
  /// with [CreateUser] model
  Future<dynamic> createUser(SignUpUser signUpUser) {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    return _netUtil.post(CUSTOMER_SIGN_UP,
        headers: header,
        encoding: Encoding.getByName("utf-8"),
        body: {
          "email": signUpUser.email,
          "password": signUpUser.password,
          "fullName": signUpUser.fullName,
          "phoneNumber": signUpUser.phoneNumber
        }).then((dynamic res) async {
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["status"]);
      } else {
        print(res["data"]["user"]);
        final prefs = await SharedPreferences.getInstance();
        // write
        prefs.setString('fullName', res["data"]["user"]["fullName"]);
        prefs.setString('email', res["data"]["user"]["email"]);
        prefs.setString('phoneNumber', res["data"]["user"]["phoneNumber"]);
        prefs.setInt(
            'numberVerification', res["data"]["user"]["numberVerification"]);
        prefs.setString('accessToken', res["token"]);
        return SignUpUser.map(res["data"]["user"], res["token"], res["status"]);
        //return (res["message"]);
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  /// A function that creates a new user POST.
  /// with [CreateUser] model
  Future<dynamic> updateUser(CompleteProfile completeProfile) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';

    print( completeProfile.nextOfKinName);
    print( completeProfile.nextOfKinPhone);
    print( completeProfile.nextOfKinEmail);
    print( completeProfile.childrenNum);
    print( completeProfile.governmentID);
    print( completeProfile.maritalStatus);
    print( completeProfile.nationality);
    print( completeProfile.dob);

    return _netUtil.patch(UPDATE_USER,
        headers: header,
        encoding: Encoding.getByName("utf-8"),
        body: {
          "nextOfKinName": completeProfile.nextOfKinName,
          "nextOfKinPhoneNumber": completeProfile.nextOfKinPhone,
          "nextOfKinEmail": completeProfile.nextOfKinEmail,
          "numOfChildren": int.parse(completeProfile.childrenNum!),
          "governmentIDName": completeProfile.governmentID,
          "maritalStatus": completeProfile.maritalStatus,
          "nationality": completeProfile.nationality,
          "dateOfBirth": completeProfile.dob,
        }).then((dynamic res) async {
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        print("This shit didnt work");
        throw (res["message"]);
      } else {
        print(res["data"]["user"]);
        final prefs = await SharedPreferences.getInstance();
        // write
        return "Profile Updated Successfully";
        //return (res["message"]);
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<dynamic> verifyUser(otpNum) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil.patch(VERIFY_USER,
        headers: header,
        encoding: Encoding.getByName("utf-8"),
        body: {
          "numToken": otpNum,
        }).then((dynamic res) async {
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        print("This shit didn't work");
        throw (res["message"]);
      } else {
        final prefs = await SharedPreferences.getInstance();
        // write
        return "User Verified Successfully";
        //return (res["message"]);
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }
  /// A function that creates a new user POST.
  /// with [CreateUser] model
  Future<dynamic> updateEmail(String email) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil.patch(UPDATE_EMAIL,
        headers: header,
        encoding: Encoding.getByName("utf-8"),
        body: {
          "email": email,
        }).then((dynamic res) async {
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        print("This shit didnt work");
        throw (res["message"]);
      } else {
        return "Profile Updated Successfully";
        //return (res["message"]);
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<dynamic> declineInvite(String inviteID) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil.patch("${BASE_URL}assets/collaborators/$inviteID",
        headers: header,
        encoding: Encoding.getByName("utf-8"),
        body: {
          "accepted": false,
        }).then((dynamic res) async {
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        print("This shit didnt work");
        throw (res["message"]);
      } else {
        return "Profile Updated Successfully";
        //return (res["message"]);
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<dynamic> acceptInvite(String inviteID) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    String baseUrl= "${BASE_URL}assets/invite";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil.patch("${BASE_URL}assets/collaborators/$inviteID",
        headers: header,
        encoding: Encoding.getByName("utf-8"),
        body: {
          "accepted": true,
        }).then((dynamic res) async {
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        print("This shit didnt work");
        throw (res["message"]);
      } else {
        return "Profile Updated Successfully";
        //return (res["message"]);
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  /// A function that creates a new user POST.
  /// with [CreateUser] model
  Future<dynamic> updatePassword(String currentPassword,String newPassword,) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil.patch(UPDATE_PASSWORD,
        headers: header,
        encoding: Encoding.getByName("utf-8"),
        body: {
          "currentPassword": currentPassword,
          "newPassword": newPassword,
        }).then((dynamic res) async {
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        print("This shit didnt work");
        throw (res["message"]);
      } else {
        return "Profile Updated Successfully";
        //return (res["message"]);
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<dynamic> updateMembership(CompleteProfile completeProfile) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil.patch(UPDATE_USER,
        headers: header,
        encoding: Encoding.getByName("utf-8"),
        body: {
          "paymentPlan2": completeProfile.paymentPlanText,
          "paymentPlan1": completeProfile.paymentPlanAmount,
        }).then((dynamic res) async {
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
        print(res["data"]["user"]);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('fullName', res["data"]["user"]["fullName"]);
        prefs.setString('photo', res["data"]["user"]["photo"]);
        return res["data"]["user"]["fullName"];
        //return (res["message"]);
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }




  Future<dynamic> createBeneficiary(AddBeneficiary addBeneficiary, assetID, String assetType) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    print(CREATE_ASSET_BENEFICIARY);
    print("This is the base URL");
    return _netUtil.post(CREATE_ASSET_BENEFICIARY,
        headers: header,
        encoding: Encoding.getByName("utf-8"),
        body: {
          "fullName":addBeneficiary.fullName,
          "email":addBeneficiary.emailAddress,
          "phoneNumber":addBeneficiary.phoneNumber,
          "assetType": assetType,

          "assetId":assetID,
        }).then((dynamic res) async {
      Map<String, dynamic> responseArray = res;
      print(res);
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
        return res["message"];
        //return (res["message"]);
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<dynamic> addBeneficiary(AddBeneficiary addBeneficiary, assetID, String assetType) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    print(ADD_ASSET_BENEFICIARY);
    print("This is the base URL");
    return _netUtil.post(ADD_ASSET_BENEFICIARY,
        headers: header,
        encoding: Encoding.getByName("utf-8"),
        body: {
          "assetId":assetID,
          "assetType": assetType,
          "beneficiaries": [
            addBeneficiary.beneficiaryID
          ]

        }).then((dynamic res) async {
      Map<String, dynamic> responseArray = res;
      print(res);
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
        return res["message"];
        //return (res["message"]);
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }




  Future<dynamic> createSettingsBeneficiary(AddBeneficiary addBeneficiary) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    print(CREATE_ASSET_BENEFICIARY);
    print("This is the base URL");
    return _netUtil.post(CREATE_ASSET_BENEFICIARY,
        headers: header,
        encoding: Encoding.getByName("utf-8"),
        body: {
          "fullName":addBeneficiary.fullName,
          "email":addBeneficiary.emailAddress,
          "phoneNumber":addBeneficiary.phoneNumber,
        }).then((dynamic res) async {
      Map<String, dynamic> responseArray = res;
      print(res);
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
        return res["message"];
        //return (res["message"]);
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }



  Future<dynamic> createCollaborator(CollaboratorModel collabDetails, List<String> selectedItems, String assetType) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    print(CREATE_COLLABORATOR);
    print("This is the base URL");
    return _netUtil.post(CREATE_COLLABORATOR,
        headers: header,
        encoding: Encoding.getByName("utf-8"),
        body: {
          "assets":selectedItems,
          "email":collabDetails.emailAddress,
          "fullName":collabDetails.fullName,
          "propertyType": assetType,
          "canViewAll": true,

        }).then((dynamic res) async {
      Map<String, dynamic> responseArray = res;
      print(res);
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
        return res["message"];
        //return (res["message"]);
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }


  Future<dynamic> loginUser(
      String email,
      String password,
      ) {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    return _netUtil.postLogin(LOGIN_TEST,
        headers: header,
        encoding: Encoding.getByName("utf-8"),
        body: {"email": email, "password": password}).then((dynamic res) async {
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
        final prefs = await SharedPreferences.getInstance();

        prefs.setString('token', res["token"]);
        prefs.setString('fullName', res["data"]["user"]["fullName"]);
        prefs.setString('email', res["data"]["user"]["email"]);
        if(res["data"]["user"]["photo"]!=null){
          prefs.setString('photo', res["data"]["user"]["photo"]);
        }
        else{
          prefs.setString('photo',"Nothing");
        }

        prefs.setString('phoneNumber', res["data"]["user"]["phoneNumber"]);
        prefs.setInt(
            'numberVerification', res["data"]["user"]["numberVerification"]);

        prefs.setString('accessToken', res["token"]);

        print(res["data"]["user"]["fullName"]);
        return res["data"]["user"]["fullName"];
      }
    }).catchError((e) {
      print(email);
      print(password);
      errorHandler.handleError(e);
    });
  }


  /// A function that fetches a users created delivery requests.
  Future<ProfileDetails> getProfileDetails(context) async {

    var profileDetails = ProfileDetails();
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil
        .get(FETCH_PROFILE, headers: header)
        .then((dynamic res) {
      print("This is prfofile detrialsd");
      print(res);
      Map<String, dynamic> responseArray = res;
      Map<String, dynamic> responseArray2 =res["data"]["user"];
      print(res["data"]["user"]["phoneNumber"]);
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {

        profileDetails.fullName= prefs.getString('fullName');
        profileDetails.email= prefs.getString('email');
        profileDetails.phoneNumber= res["data"]["user"]["phoneNumber"];
        profileDetails.profilePic= res["data"]["user"]["photo"];
        //profileDetails.paymentType= res["data"]["user"]["paymentPlan"]["name"];
        //  profileDetails.paymentPrice= res["data"]["user"]["paymentPlan"]["price"];
        print(profileDetails);
        return profileDetails;
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }


  Future<List<LinkedInvitesList>> getLinkedInvites(context) async {


    List<LinkedInvitesList> linkedInvitesList = [];
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil
        .get(FETCH_LINKED_INVITES, headers: header)
        .then((dynamic res) {
      print(res);
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
        var details = res["data"]["linkedAssets"] as List;
        linkedInvitesList = details
            .map<LinkedInvitesList>(
                (json) => LinkedInvitesList.fromJson(json))
            .toList();
        return linkedInvitesList;
      }
    }).catchError((e) {
      return errorHandler.handleError(e);
    });
  }

  Future<List<PendingInvites>> getPendingInvites(context) async {


    List<PendingInvites> pendingInvites = [];
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil
        .get(FETCH_PENDING_INVITES, headers: header)
        .then((dynamic res) {
      print(res);
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
        var details = res["data"]["invites"] as List;
        pendingInvites = details
            .map<PendingInvites>(
                (json) => PendingInvites.fromJson(json))
            .toList();
        return pendingInvites;
      }
    }).catchError((e) {
      return errorHandler.handleError(e);
    });
  }




  Future<List<IndividualAssetListModel>> getCollabAssets(context, String userID) async {


    List<IndividualAssetListModel> collabAssetsList = [];
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };



    String baseUrl= "${BASE_URL}assets/linked/individual/$userID";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil
        .get(baseUrl, headers: header)
        .then((dynamic res) {
      print(res);
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
        var details = res["data"]["linkedAssets"] as List;
        collabAssetsList = details
            .map<IndividualAssetListModel>(
                (json) => IndividualAssetListModel.fromJson(json))
            .toList();
        return collabAssetsList;
      }
    }).catchError((e) {
      return errorHandler.handleError(e);
    });
  }

  Future<List<AddBeneficiary>> getBeneficiaryList(context) async {

    List<AddBeneficiary> beneficiaryList = [];
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil
        .get(FETCH_BENEFICIARIES, headers: header)
        .then((dynamic res) {
      print(res);
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
        var details = res["data"]["beneficiaries"] as List;
        beneficiaryList = details
            .map<AddBeneficiary>(
                (json) => AddBeneficiary.fromJson(json))
            .toList();
        return beneficiaryList;
      }
    }).catchError((e) {
      return errorHandler.handleError(e);
    });
  }


  Future<List<AddBeneficiary>> getAssetDetailsBeneficiary(context, userID, assetType) async {

    List<AddBeneficiary> beneficiaryList = [];

    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil
        .post(FETCH_ASSET_DETAILS, headers: header,
        body: {"userId": userID, "type": assetType}).then((dynamic res) async {
      print(res);
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {

        var details = res["data"]["beneficiaries"] as List;

        beneficiaryList = details
            .map<AddBeneficiary>(
                (json) => AddBeneficiary.fromJson(json))
            .toList();

        return beneficiaryList;
      }
    }).catchError((e) {
      return errorHandler.handleError(e);
    });
  }


  Future<List<CollaboratorListModel>> getPersonalAssetCollaborators(context,assetType) async {

    List<CollaboratorListModel> collaboratorList = [];

    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    String baseUrl= "${BASE_URL}assets/vault/$assetType";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil
        .get(baseUrl, headers: header,
    ).then((dynamic res) async {
      print(res);
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {

        var details = res["data"]["collaborators"] as List;

        collaboratorList = details
            .map<CollaboratorListModel>(
                (json) => CollaboratorListModel.fromJson(json))
            .toList();

        return collaboratorList;
      }
    }).catchError((e) {
      return errorHandler.handleError(e);
    });
  }

  Future<List<AssetDetailModel>> getPersonalAssets(context, assetType) async {

    List<AssetDetailModel> assetDetails = [];
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };


    var baseUrl="";
    print(assetType);
    if(assetType=="real_estate"){
      baseUrl="${BASE_URL}documents/housingproperties";
    }
    else  if(assetType=="tangible_assets"){
      baseUrl="${BASE_URL}documents/intangibleassets";
    }
    else  if(assetType=="personal_assets"){
      baseUrl="${BASE_URL}documents/personaleffects";
    }


    else  if(assetType=="debts_and_liabilities"){
      baseUrl="${BASE_URL}documents/debts-and-liabilities";
    }
    else  if(assetType=="others"){
      baseUrl="${BASE_URL}documents/memoirs";
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil
        .get(baseUrl, headers: header,
    ).then((dynamic res) async {
      print(res);
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {

        var assetList = res["data"]["doc"] as List;
        assetDetails = assetList
            .map<AssetDetailModel>(
                (json) => AssetDetailModel.fromJson(json))
            .toList();

        return assetDetails;
      }
    }).catchError((e) {
      return errorHandler.handleError(e);
    });
  }


  Future<List<AssetDetailModel>> getFinancialPersonalAssets(context, assetType) async {

    List<AssetDetailModel> assetDetails = [];
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };


    var baseUrl="";


    if(assetType=="cash"){
      baseUrl="${BASE_URL}documents/financialAssets/cash";
    }
    else  if(assetType=="crypto"){
      baseUrl="${BASE_URL}documents/financialAssets/crypto";
    }
    else  if(assetType=="pension"){
      baseUrl="${BASE_URL}documents/financialAssets/pension";

    } else  if(assetType=="insurance"){
      baseUrl="${BASE_URL}documents/financialAssets/insurance";
    }


    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil
        .get(baseUrl, headers: header,
    ).then((dynamic res) async {
      print(res);
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {

        var assetList = res["data"]["doc"] as List;
        assetDetails = assetList
            .map<AssetDetailModel>(
                (json) => AssetDetailModel.fromJson(json))
            .toList();

        return assetDetails;
      }
    }).catchError((e) {
      return errorHandler.handleError(e);
    });
  }

  Future<List<AssetDetailModel>> getRealEstateAssets(context, assetType) async {

    List<AssetDetailModel> assetDetails = [];
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };


    var baseUrl= "${BASE_URL}documents/housingproperties";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil
        .get(baseUrl, headers: header,
    ).then((dynamic res) async {
      print(res);
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {

        var assetList = res["data"]["doc"] as List;

        assetDetails = assetList
            .map<AssetDetailModel>(
                (json) => AssetDetailModel.fromJson(json))
            .toList();

        return assetDetails;
      }
    }).catchError((e) {
      return errorHandler.handleError(e);
    });
  }


  Future<EditAssetModel> getAssetDetails(context, assetID, assetType) async {

    var assetDetails = EditAssetModel();

    String baseUrl="";

    if(assetType=="real_estate"){
      baseUrl= "${BASE_URL}assets/oneAsset/$assetID/HousingProperties";
    }
    else  if(assetType=="tangible_assets"){
      baseUrl="${BASE_URL}assets/oneAsset/$assetID/IntangibleAssets";
    }

    else  if(assetType=="personal_assets"){
      baseUrl="${BASE_URL}assets/oneAsset/$assetID/PersonalEffects";
    }

    else  if(assetType=="debts_and_liabilities"){
      baseUrl="${BASE_URL}assets/oneAsset/$assetID/Debts";
    }
    else  if(assetType=="others"){
      baseUrl="${BASE_URL}assets/oneAsset/$assetID/Memoirs";
    }

    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil
        .get(baseUrl, headers: header)
        .then((dynamic res) {
      print(res);

      Map<String, dynamic> responseArray =res["data"]["asset"];
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {

        assetDetails.assetName= res["data"]["asset"]["name"];
        assetDetails.assetDateAdded= res["data"]["asset"]["createdAt"];
        assetDetails.assetAddress1= res["data"]["asset"]["addressLine1"];
        assetDetails.assetAddress2= res["data"]["asset"]["addressLine2"];
        assetDetails.lga= res["data"]["asset"]["lga"];
        assetDetails.state= res["data"]["asset"]["state"];


        return assetDetails;
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }

  Future<List<dynamic>> getOneAssetDetail(context, assetID,assetType ) async {

    print("This is the ID $assetID");
    List<AssetDocumentModel> assetDocument = [];
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    String baseUrl="";

    if(assetType=="real_estate"){
      baseUrl= "${BASE_URL}assets/oneAsset/$assetID/HousingProperties";
    }
    else  if(assetType=="tangible_assets"){
      baseUrl="${BASE_URL}assets/oneAsset/$assetID/IntangibleAssets";
    }

    else  if(assetType=="personal_assets"){
      baseUrl="${BASE_URL}assets/oneAsset/$assetID/PersonalEffects";
    }

    else  if(assetType=="debts_and_liabilities"){
      baseUrl="${BASE_URL}assets/oneAsset/$assetID/Debts";
    }
    else  if(assetType=="others"){
      baseUrl="${BASE_URL}assets/oneAsset/$assetID/Memoirs";
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil
        .get(baseUrl, headers: header,
    ).then((dynamic res) async {
      print(res);
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
        print(responseArray["data"]["asset"]["assetDocument"]);
        List<dynamic> assetList = responseArray["data"]["asset"]["assetDocument"] as List;


        return assetList;
      }
    }).catchError((e) {
      return errorHandler.handleError(e);
    });
  }



  Future<List<dynamic>> getAssetDocumentList(context, assetID,assetType ) async {

    print("This is the ID $assetID");
    List<AssetDocumentModel> assetDocument = [];
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    String baseUrl="";

    if(assetType=="real_estate"){
      baseUrl= "${BASE_URL}assets/oneAsset/$assetID/HousingProperties";
    }
    else  if(assetType=="tangible_assets"){
      baseUrl="${BASE_URL}assets/oneAsset/$assetID/IntangibleAssets";
    }

    else  if(assetType=="personal_assets"){
      baseUrl="${BASE_URL}assets/oneAsset/$assetID/PersonalEffects";
    }

    else  if(assetType=="debts_and_liabilities"){
      baseUrl="${BASE_URL}assets/oneAsset/$assetID/Debts";
    }
    else  if(assetType=="others"){
      baseUrl="${BASE_URL}assets/oneAsset/$assetID/Memoirs";
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil
        .get(baseUrl, headers: header,
    ).then((dynamic res) async {
      print(res);
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
          print(responseArray["data"]["asset"]["assetDocument"]);
        List<dynamic> assetList = responseArray["data"]["asset"]["assetDocument"] as List;


        return assetList;
      }
    }).catchError((e) {
      return errorHandler.handleError(e);
    });
  }

  Future<List<dynamic>> getFinancialDocumentList(context, assetID,assetType ) async {

    print("This is the ID $assetID");
    List<AssetDocumentModel> assetDocument = [];
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    String baseUrl="";

    if(assetType=="cash"){
      baseUrl= "${BASE_URL}assets/oneAsset/$assetID/CashAssets";
    }
    else  if(assetType=="crypto"){
      baseUrl="${BASE_URL}assets/oneAsset/$assetID/CryptoAssets";
    }

    else  if(assetType=="insurance"){
      baseUrl="${BASE_URL}assets/oneAsset/$assetID/InsuranceAssets";
    }

    else  if(assetType=="pension"){
      baseUrl="${BASE_URL}assets/oneAsset/$assetID/PensionAssets";
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil
        .get(baseUrl, headers: header,
    ).then((dynamic res) async {
      print(res);
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
        print(responseArray["data"]["asset"]["assetDocument"]);
        List<dynamic> assetList = responseArray["data"]["asset"]["assetDocument"] as List;


        return assetList;
      }
    }).catchError((e) {
      return errorHandler.handleError(e);
    });
  }
  /// A function that fetches a users created delivery requests.




  Future<List<AssetDocumentModel>> getAssetCollabDocumentList(context, assetID) async {

    List<AssetDocumentModel> assetDocument = [];
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };


    var baseUrl= "${BASE_URL}assets/oneAsset/collaborators/$assetID";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil
        .get(baseUrl, headers: header,
    ).then((dynamic res) async {
      print(res);
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {

        var assetList = res["data"]["asset"]["documents"] as List;
        assetDocument = assetList
            .map<AssetDocumentModel>(
                (json) => AssetDocumentModel.fromJson(json))
            .toList();

        return assetDocument;
      }
    }).catchError((e) {
      return errorHandler.handleError(e);
    });
  }

  Future<List<CollabModel>> getCollabList(context, assetID, assetType) async {

    List<CollabModel> collabList = [];
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    String baseUrl="";



    if(assetType=="real_estate"){
      baseUrl= "${BASE_URL}assets/oneAsset/collaborators/$assetID/HousingProperties";
    }
    else  if(assetType=="tangible_assets"){
      baseUrl= "${BASE_URL}assets/oneAsset/collaborators/$assetID/IntangibleAssets";
    }

    else  if(assetType=="personal_assets"){
      baseUrl= "${BASE_URL}assets/oneAsset/collaborators/$assetID/PersonalEffects";
    }

    else  if(assetType=="debts_and_liabilities"){
      baseUrl= "${BASE_URL}assets/oneAsset/collaborators/$assetID/Debts";
    }
    else  if(assetType=="others"){
      baseUrl= "${BASE_URL}assets/oneAsset/collaborators/$assetID/Memoirs";

    }






    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil
        .get(baseUrl, headers: header,
    ).then((dynamic res) async {
      print(res);
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {

        var assetList = res["data"]["collaborators"] as List;
        collabList = assetList
            .map<CollabModel>(
                (json) => CollabModel.fromJson(json))
            .toList();

        return collabList;
      }
    }).catchError((e) {
      return errorHandler.handleError(e);
    });
  }

  Future<List<CollabModel>> getFinancialCollabList(context, assetID, assetType) async {

    List<CollabModel> collabList = [];
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };

    String baseUrl="";


    if(assetType=="cash"){

      baseUrl= "${BASE_URL}assets/oneAsset/collaborators/$assetID/CashAssets";
    }
    else  if(assetType=="crypto"){
      baseUrl= "${BASE_URL}assets/oneAsset/collaborators/$assetID/CryptoAssets";
    }
    else  if(assetType=="pension"){
      baseUrl= "${BASE_URL}assets/oneAsset/collaborators/$assetID/PensionAssets";

    } else  if(assetType=="insurance"){
      baseUrl= "${BASE_URL}assets/oneAsset/collaborators/$assetID/InsuranceAssets";
    }






    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil
        .get(baseUrl, headers: header,
    ).then((dynamic res) async {
      print(res);
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {

        var assetList = res["data"]["collaborators"] as List;
        collabList = assetList
            .map<CollabModel>(
                (json) => CollabModel.fromJson(json))
            .toList();

        return collabList;
      }
    }).catchError((e) {
      return errorHandler.handleError(e);
    });
  }

  Future<List<AssetDetailModel>> getAssetDetailsAssets(context, userID, assetType) async {

    List<AssetDetailModel> assetDetails = [];
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    print("This is the function");


    String finalAssetType="";
    if( assetType== "real_estate"){
      finalAssetType="HousingProperties";
    }
    else if(assetType=="personal_assets"){
      finalAssetType="PersonalEffects";
    }
    else if(assetType=="debts_and_liabilities"){
      finalAssetType="Debts";
    }
    else if(assetType=="others"){
      finalAssetType="Memoirs";
    }
    else if(assetType=="tangible_assets"){
      finalAssetType="IntangibleAssets";
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';

     const FETCH_ASSET_DETAILS= "${BASE_URL}assets/collab/asset";
    return _netUtil
        .post(FETCH_ASSET_DETAILS, headers: header,
        body: {"userId": userID,
          "assetType": finalAssetType}).then((dynamic res) async {
      print(res);
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {

        var assetList = res["data"]["assets"] as List;
        assetDetails = assetList
            .map<AssetDetailModel>(
                (json) => AssetDetailModel.fromJson(json))
            .toList();

        return assetDetails;
      }
    }).catchError((e) {
      return errorHandler.handleError(e);
    });
  }

  /// A function that fetches a users created delivery requests.
  Future<AssetOverviewModel> getAssetOverview(context) async {

    var assetOverview = AssetOverviewModel();
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil
        .get(FETCH_ASSET_OVERVIEW, headers: header)
        .then((dynamic res) {
      print(res);
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {


        assetOverview.financialAssets=
            res["data"]["assets"][1]["percentage"]!=null?
            (res["data"]["assets"][1]["percentage"].toStringAsFixed(1)).toString(): "0";

        assetOverview.tangibleAssets=
        res["data"]["assets"][3]["percentage"]!=null?
            (res["data"]["assets"][3]["percentage"].toStringAsFixed(1)).toString(): "0";
        assetOverview.personalAssets=
        res["data"]["assets"][5]["percentage"]!=null?
            (res["data"]["assets"][5]["percentage"].toStringAsFixed(1)).toString(): "0";
        assetOverview.debtsAndLiabilities=
        res["data"]["assets"][0]["percentage"]!=null?
            (res["data"]["assets"][0]["percentage"].toStringAsFixed(1)).toString(): "0";
        assetOverview.others=
        res["data"]["assets"][4]["percentage"]!=null?
            (res["data"]["assets"][4]["percentage"].toStringAsFixed(1)).toString(): "0";
        assetOverview.realEstate=
        res["data"]["assets"][2]["percentage"]!=null?
            (res["data"]["assets"][2]["percentage"].toStringAsFixed(1)).toString(): "0";

        print(   assetOverview.realEstate);
        print(   assetOverview.financialAssets);
        print(   assetOverview.tangibleAssets);
        print(   assetOverview.personalAssets);
        print(   assetOverview.debtsAndLiabilities);
        print(   assetOverview.others);


        return assetOverview;
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }


  /// A function that fetches a users created delivery requests.
  Future<LawyerModel> getLawyerDetails(context) async {

    var lawyerDetails = LawyerModel();
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil
        .get(FETCH_LAWYER_DETAILS, headers: header)
        .then((dynamic res) {
      print(res);
      List <dynamic> responseArray = res["data"]["doc"];
      print(responseArray);
      if (responseArray.contains('error')) {
        throw (res["message"]);
      } else {
        if(res["count"]==0){
          lawyerDetails.lawyerName="";
        }
        else{
          lawyerDetails.lawyerName= responseArray[0]['lawyerName'];
          lawyerDetails.lawyerEmail= responseArray[0]['lawyerEmail'];
          lawyerDetails.lawyerPhone= responseArray[0]['lawyerPhoneNumber'];
          lawyerDetails.lawyerAddress= responseArray[0]['lawyerAddress'];
        }



        return lawyerDetails;
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }


  Future<dynamic> createLawyer(LawyerModel lawyerModel) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil.post(CREATE_LAWYER,
        headers: header,
        encoding: Encoding.getByName("utf-8"),
        body: {
          "lawyerName": lawyerModel.lawyerName,
          "lawyerEmail": lawyerModel.lawyerEmail,
          "lawyerPhoneNumber": lawyerModel.lawyerPhone.toString(),
          "lawyerAddress": "Nigeria"
        }).then((dynamic res) async {
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
        print(res["data"]["lawyer"]);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('lawyerID', res["data"]["lawyer"]["_id"]);
        return res["data"]["lawyer"]["_id"];
        //return (res["message"]);
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }


  Future<dynamic> editLawyerDetails (LawyerModel lawyerModel, String lawyerID) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    String baseURL= "${BASE_URL}lawyers/$lawyerID";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil.patch(baseURL,
        headers: header,
        encoding: Encoding.getByName("utf-8"),
        body: {

          "lawyerEmail": lawyerModel.lawyerEmail,
        }).then((dynamic res) async {
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {

        return res["data"];
        //return (res["message"]);
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }




  Future<dynamic> deleteLawyerDetails (String lawyerID) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    String baseURL= "${BASE_URL}lawyers/$lawyerID";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil.delete(baseURL,
      headers: header,

    ).then((dynamic res) async {


    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }


  Future<dynamic> deleteAsset (String assetID, String assetType) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };


String baseURL="";

    if(assetType=="real_estate"){
      baseURL= "${BASE_URL}documents/housingproperties/$assetID";
    }
    else  if(assetType=="tangible_assets"){
      baseURL= "${BASE_URL}documents/intangibleassets/$assetID";
    }

    else  if(assetType=="personal_assets"){
      baseURL= "${BASE_URL}documents/personaleffects/$assetID";
    }

    else  if(assetType=="debts_and_liabilities"){
      baseURL= "${BASE_URL}documents/debts-and-liabilities/$assetID";

    }
    else  if(assetType=="others"){
      baseURL= "${BASE_URL}documents/memoirs/$assetID";

    }
    else  if(assetType=="cash"){
      baseURL= "${BASE_URL}documents/financialAssets/cash/$assetID";
    }

    else  if(assetType=="crypto"){
      baseURL= "${BASE_URL}documents/financialAssets/crypto/$assetID";
    }

    else  if(assetType=="insurance"){
      baseURL= "${BASE_URL}documents/financialAssets/insurance/$assetID";

    }
    else  if(assetType=="pension"){
      baseURL= "${BASE_URL}documents/financialAssets/pension/$assetID";

    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil.delete(baseURL,
      headers: header,

    ).then((dynamic res) async {


    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }


  Future<dynamic> editBeneficiary (AddBeneficiary beneficiary,) async {
    Map<String, String> header;
    header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    String baseURL= "${BASE_URL}assets/beneficiary";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
    return _netUtil.patch(baseURL,
        headers: header,
        encoding: Encoding.getByName("utf-8"),
        body: {
          "beneficiaryId": beneficiary.beneficiaryID,
          "fullName": beneficiary.fullName,
          "email": beneficiary.emailAddress,
        }).then((dynamic res) async {
      Map<String, dynamic> responseArray = res;
      if (responseArray.containsKey('error')) {
        throw (res["message"]);
      } else {
        return res["data"];
        //return (res["message"]);
      }
    }).catchError((e) {
      errorHandler.handleError(e);
    });
  }















//
//

//
//
//   Future<dynamic> createFinancialAssets(FinancialAssets financialAssets) async {
//     Map<String, String> header;
//     header = {
//       "Accept": "application/json",
//       "Content-Type": "application/json",
//     };
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
//     return _netUtil.post(CREATE_FINANCIAL_ASSETS,
//         headers: header,
//         encoding: Encoding.getByName("utf-8"),
//         body: {
//           "title":financialAssets.propTitle,
//           "country":financialAssets.propCountry ,
//           "sharesPercent":financialAssets.sharesHeld ,
//           "sharesLocation":financialAssets.shareLocation!.toLowerCase() ,
//           "brokers":financialAssets.brokers ,
//           "stocksHeld":financialAssets.stockHeld,
//           "stocksType": financialAssets.stockType ,
//           "numOfSharesPerStock": financialAssets.sharesByStock ,
//           "registeredTo":financialAssets.nameRegisteredToStock ,
//         }).then((dynamic res) async {
//       Map<String, dynamic> responseArray = res;
//       if (responseArray.containsKey('error')) {
//         throw (res["message"]);
//       } else {
//         String assetID=(res["data"]["doc"]["id"]);
//         final prefs = await SharedPreferences.getInstance();
//         // write
//         return assetID;
//       }
//     }).catchError((e) {
//       errorHandler.handleError(e);
//     });
//   }
//
//
//
//   Future< dynamic> addBeneficiaryIntangible(
//       String videoType,
//       String propertyName,
//       File videoFile) async {
//     Map<String, String> header;
//     String baseUrl=CREATE_INTANGIBLE_ASSETS;
//     header = {
//       "Accept": "application/json",
//       "Content-Type": "application/json",
//     };
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
//     var uri = Uri.parse(baseUrl);
//     http.MultipartRequest request = http.MultipartRequest('POST', uri);
//     request.headers.addAll(header);
//     request.fields['title'] = propertyName.toString().toLowerCase();
//     request.fields['assetType'] = videoType.toString().toLowerCase();
//      print(videoFile.path);
//     print(baseUrl);
//     var multipartFile =
//     await http.MultipartFile.fromPath("video", videoFile.path);
//    request.files.add(multipartFile);
//     var streamedResponse = await request.send();
//     var response = await http.Response.fromStream(streamedResponse);
//     print(response.body);
//     final result = jsonDecode(response.body) as Map<String, dynamic>;
//     print(response.statusCode);
//     if(response.statusCode<200 || response.statusCode>400){
//       return result["message"];
//     }
//     String assetID=(result["data"]["doc"]["id"]);
//     print(assetID);
//     return result["data"]["doc"]["id"];
//   }
// /*  /// A function that logs in a user POST.
//   /// with [CreateUser] model
//   Future<dynamic> loginUser(String email, String password) {
//     return _netUtil.postLogin(CUSTOMER_LOGIN,
//         body: {"email": email, "password": password}).then((dynamic res) {
//       Map<String, dynamic> responseArray = res;
//       if (responseArray.containsKey('error')) {
//         throw (res["message"]);
//       } else {
//         return UserInfo.map(res["payload"]);
//       }
//     }).catchError((e) {
//       errorHandler.handleError(e);
//     });
//   }*/
//
//   /// A function that logs in a user POST.
//   /// with [UserInfo] model

//   /// A function that logs in a user POST.
//   /// with [CreateUser] model
//   Future<dynamic> loginAgent(String email, String password) {
//     return _netUtil.post(AGENT_LOGIN,
//         body: {"email": email, "password": password}).then((dynamic res) {
//       Map<String, dynamic> responseArray = res;
//       if (responseArray.containsKey('error')) {
//         throw (res["message"]);
//       } else {
//         return UserInfo.map(res["payload"]);
//       }
//     }).catchError((e) {
//       errorHandler.handleError(e);
//     });
//   }
//
//   /// A function that generates a confirmation code with POST.
//   Future<dynamic> generateCode(String type, int deliveryId) async {
//     Map<String, String> header;
//     header = {
//       "Accept": "application/json",
//       "Content-Type": "application/json",
//     };
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
//     return _netUtil.post(GENERATE_CODE,
//         headers: header,
//         body: {"type": type, "deliveryId": deliveryId}).then((dynamic res) {
//       Map<String, dynamic> responseArray = res;
//       if (responseArray.containsKey('error')) {
//         throw (res["message"]);
//       } else {
//         return UserCode.map(res["payload"]);
//       }
//     }).catchError((e) {
//       errorHandler.handleError(e);
//     });
//   }
//
//   /// A function that fetches a users created delivery requests.
//   Future<List<DeliveryRequestDetails>> fetchDeliveryRequests() async {
//     List<DeliveryRequestDetails> requestDetails = [];
//     Map<String, String> header;
//     header = {
//       "Accept": "application/json",
//       "Content-Type": "application/json",
//     };
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
//     return _netUtil
//         .get(FETCH_DELIVERY_REQUESTS, headers: header)
//         .then((dynamic res) {
//       print(res);
//       Map<String, dynamic> responseArray = res;
//       if (responseArray.containsKey('error')) {
//         throw (res["message"]);
//       } else {
//         var details = res["payload"] as List;
//         requestDetails = details
//             .map<DeliveryRequestDetails>(
//                 (json) => DeliveryRequestDetails.fromJson(json))
//             .toList();
//         return requestDetails;
//       }
//     }).catchError((e) {
//       errorHandler.handleError(e);
//     });
//   }
//


//   Future<List<HousePropertyList>> getHousingProperties(context) async {
//     String? baseUrl=FECTH_HOUSING_PROPERTY;
//
//     List<HousePropertyList> propertyList = [];
//     Map<String, String> header;
//     header = {
//       "Accept": "application/json",
//       "Content-Type": "application/json",
//     };
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
//     return _netUtil
//         .get(baseUrl, headers: header)
//         .then((dynamic res) {
//       print(res);
//       Map<String, dynamic> responseArray = res;
//       if (responseArray.containsKey('error')) {
//         throw (res["message"]);
//       } else {
//         var details = res["data"]["doc"] as List;
//         propertyList = details
//             .map<HousePropertyList>(
//                 (json) => HousePropertyList.fromJson(json))
//             .toList();
//         print("propertyList.length");
//         print(propertyList.length);
//         return propertyList;
//       }
//     }).catchError((e) {
//       errorHandler.handleError(e);
//     });
//   }
//
//   Future<List<IntangibleAssetsList>> getIntangibleAssets(context) async {
//     String? baseUrl=FECTH_INTANGIBLE_ASSETS;
//
//     List<IntangibleAssetsList> propertyList = [];
//     Map<String, String> header;
//     header = {
//       "Accept": "application/json",
//       "Content-Type": "application/json",
//     };
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
//     return _netUtil
//         .get(baseUrl, headers: header)
//         .then((dynamic res) {
//       print(res);
//       Map<String, dynamic> responseArray = res;
//       if (responseArray.containsKey('error')) {
//         throw (res["message"]);
//       } else {
//         var details = res["data"]["doc"] as List;
//         propertyList = details
//             .map<IntangibleAssetsList>(
//                 (json) => IntangibleAssetsList.fromJson(json))
//             .toList();
//         return propertyList;
//       }
//     }).catchError((e) {
//       errorHandler.handleError(e);
//     });
//   }
//
//   Future<List<FinancialAssetList>> getFinancialAssets(context) async {
//     String? baseUrl=FECTH_FINANCIAL_ASSETS;
//
//     List<FinancialAssetList> propertyList = [];
//     Map<String, String> header;
//     header = {
//       "Accept": "application/json",
//       "Content-Type": "application/json",
//     };
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
//     return _netUtil
//         .get(baseUrl, headers: header)
//         .then((dynamic res) {
//       print(res);
//       Map<String, dynamic> responseArray = res;
//       if (responseArray.containsKey('error')) {
//         throw (res["message"]);
//       } else {
//         var details = res["data"]["doc"] as List;
//         propertyList = details
//             .map<FinancialAssetList>(
//                 (json) => FinancialAssetList.fromJson(json))
//             .toList();
//         return propertyList;
//       }
//     }).catchError((e) {
//       errorHandler.handleError(e);
//     });
//   }
//
//
//   Future<List<PersonalPropertyList>> getPersonalAssets(context) async {
//     String? baseUrl=FECTH_PERSONAL_ASSETS;
//
//     List<PersonalPropertyList> propertyList = [];
//     Map<String, String> header;
//     header = {
//       "Accept": "application/json",
//       "Content-Type": "application/json",
//     };
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
//     return _netUtil
//         .get(baseUrl, headers: header)
//         .then((dynamic res) {
//       print(res);
//       Map<String, dynamic> responseArray = res;
//       if (responseArray.containsKey('error')) {
//         throw (res["message"]);
//       } else {
//         var details = res["data"]["doc"] as List;
//         propertyList = details
//             .map<PersonalPropertyList>(
//                 (json) => PersonalPropertyList.fromJson(json))
//             .toList();
//         return propertyList;
//       }
//     }).catchError((e) {
//       errorHandler.handleError(e);
//     });
//   }
//
//
//   /// A function that fetches a providers logistics fares.
//   Future<List<LogisticsFares>> fetchLogisticsFares() async {
//     List<LogisticsFares> logisticsFares = [];
//     Map<String, String> header;
//     header = {
//       "Accept": "application/json",
//       "Content-Type": "application/json",
//     };
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
//     return _netUtil
//         .get(FETCH_LOGISTICS_FARE, headers: header)
//         .then((dynamic res) {
//       print(res);
//       Map<String, dynamic> responseArray = res;
//       if (responseArray.containsKey('error')) {
//         throw (res["message"]);
//       } else {
//         var fares = res["payload"] as List;
//         logisticsFares = fares
//             .map<LogisticsFares>((json) => LogisticsFares.fromJson(json))
//             .toList();
//         return logisticsFares;
//       }
//     }).catchError((e) {
//       errorHandler.handleError(e);
//     });
//   }
//
//   /// A function that fetches created delivery requests with 'started' status for the agent with POST.
//   Future<List<AgentDeliveriesDetails>> fetchStartedDeliveries() async {
//     List<AgentDeliveriesDetails> agentRequestDetails = [];
//     Map<String, String> header;
//     header = {
//       "Accept": "application/json",
//       "Content-Type": "application/json",
//     };
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
//     return _netUtil
//         .get(FETCH_STARTED_DELIVERIES, headers: header)
//         .then((dynamic res) {
//       print(res);
//       Map<String, dynamic> responseArray = res;
//       if (responseArray.containsKey('error')) {
//         throw (res["message"]);
//       } else {
//         var details = res["payload"] as List;
//         agentRequestDetails = details
//             .map<AgentDeliveriesDetails>(
//                 (json) => AgentDeliveriesDetails.fromJson(json))
//             .toList();
//         return agentRequestDetails;
//       }
//     }).catchError((e) {
//       errorHandler.handleError(e);
//     });
//   }
//
//   /// A function that fetches created delivery requests with 'started' status for the agent with POST.
//   Future<List<AgentDeliveriesDetails>> fetchProcessingDeliveries() async {
//     List<AgentDeliveriesDetails> agentRequestDetails = [];
//     Map<String, String> header;
//     header = {
//       "Accept": "application/json",
//       "Content-Type": "application/json",
//     };
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
//     return _netUtil
//         .get(FETCH_PROCESSING_DELIVERIES, headers: header)
//         .then((dynamic res) {
//       print(res);
//       Map<String, dynamic> responseArray = res;
//       if (responseArray.containsKey('error')) {
//         throw (res["message"]);
//       } else {
//         var details = res["payload"] as List;
//         agentRequestDetails = details
//             .map<AgentDeliveriesDetails>(
//                 (json) => AgentDeliveriesDetails.fromJson(json))
//             .toList();
//         return agentRequestDetails;
//       }
//     }).catchError((e) {
//       errorHandler.handleError(e);
//     });
//   }
//
//   /// A function that fetches created delivery requests with 'started' status for the agent with POST.
//   Future<String> deleteAssets(String assetID, String assetType) async {
//     Map<String, String> header;
//     String? baseurl;
//     header = {
//       "Accept": "application/json",
//     };
//     if(assetType=="house"){
//       baseurl=DELETE_HOUSING_PROPERTY;
//     }
//     else if(assetType=="personal"){
//       baseurl=DELETE_PERSONAL_PROPERTY;
//     }
//     else if(assetType=="intangible"){
//       baseurl=DELETE_INTANGIBLE_PROPERTY;
//     }
//     else if(assetType=="financial"){
//       baseurl= DELETE_FINANCIAL_PROPERTY;
//     }
//
//     String finalBaseUrl= "${baseurl!}/$assetID";
//     print(finalBaseUrl);
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     header['Authorization'] = 'Bearer ${prefs.getString('accessToken')}';
//     return _netUtil
//         .delete(finalBaseUrl, headers: header )
//         .then((dynamic res) {
//       String responseArray = res;
//       if (responseArray=="no") {
//        return "Delete Unsuccessful";
//       } else {
//         return "Deleted Successfully";
//       }
//     }).catchError((e) {
//       errorHandler.handleError(e);
//     });
//   }
}
