import 'package:mantled_app/model/CollaboratorListModel.dart';

/// A class to hold my [CompleteProfile] model

class AssetDetailModel {
  /// Constructor for [CompleteProfile] class
  AssetDetailModel({
    this.assetName,
    this.assetDateAdded,
    this.assetType,
    this.assetID,
    this.assetAddress1,
    this.assetAddress2,

  });

  String? assetName;
  String? assetDateAdded;
  String? assetType;
  String? assetID;
  String? assetAddress1;
  String? assetAddress2;
  String? beneficiaryName;





  factory AssetDetailModel.fromJson(Map<String, dynamic> json) =>
      AssetDetailModel(
        assetName: json['assetName'],
        assetDateAdded: json['createdAt'],
        assetType: json["assetType"],
        assetID:  json['_id'],
        assetAddress1: json['propertyAddress']!=null ? json['propertyAddress'][0]['address'] as String:"Lagos, Nigeria",

      );



}
