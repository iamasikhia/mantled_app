/// A class to hold my [CompleteProfile] model

class IndividualAssetListModel {
  /// Constructor for [CompleteProfile] class
  IndividualAssetListModel({
    this.assetCount,
    this.assetLastModified,
    this.assetType,



  });

  int? assetCount;
  String? assetLastModified;
  String? assetType;




  factory IndividualAssetListModel.fromJson(Map<String, dynamic> json) =>
      IndividualAssetListModel(
        assetCount: json['count'],
        assetLastModified: json['lastModified'],
        assetType: json['type'],

      );



}
