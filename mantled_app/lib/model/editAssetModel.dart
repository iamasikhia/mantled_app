import 'package:mantled_app/model/CollaboratorListModel.dart';

/// A class to hold my [CompleteProfile] model

class EditAssetModel {
  /// Constructor for [CompleteProfile] class
  EditAssetModel({
    this.assetName,
    this.assetDateAdded,
    this.assetID,
    this.assetAddress1,
    this.assetAddress2,
    this.country,
    this.lga,
    this.state




  });

  String? assetName;
  String? assetDateAdded;
  String? assetID;
  String? assetAddress1;
  String? assetAddress2;
  String? lga;
  String? state;
  String? country;




  factory EditAssetModel.fromJson(Map<String, dynamic> json) =>
      EditAssetModel(
        assetName: json['name'],
        assetDateAdded: json['createdAt'],
        assetID:  json['_id'],
        assetAddress1: json['addressLine1'],
        assetAddress2: json['addressLine2'],
        lga: json['lga'],
        state: json['state'],
        country: json['country'],

      );



}
