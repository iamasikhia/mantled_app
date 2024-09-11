import 'package:mantled_app/model/CollaboratorListModel.dart';

/// A class to hold my [CompleteProfile] model

class AssetDocumentModel {
  /// Constructor for [CompleteProfile] class
  AssetDocumentModel({
    this.assetName,
    this.assetUrl,
    this.assetDateAdded,
    this.assetID,





  });

  String? assetName;
  String? assetUrl;
  String? assetDateAdded;
  String? assetID;



  factory AssetDocumentModel.fromJson(Map<String, dynamic> json) =>
      AssetDocumentModel(
        assetName: json['documentType'],
        assetUrl: json['documentUrl'],
        assetDateAdded: json['createdAt'],
        assetID:  json['_id'],
      );



}
