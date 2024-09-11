/// A class to hold my [CompleteProfile] model

class CollabModel {
  /// Constructor for [CompleteProfile] class
  CollabModel({
    this.collabID,
    this.collabName,
    this.collabPicture,

  });

  /// A string variable to hold the users email
  String? collabID;
  String? collabName;
  String? collabPicture;


  factory CollabModel.fromJson(Map<String, dynamic> json) =>
      CollabModel(
        collabID: json['_id'],
        collabName: json["userId"]['fullName'],
        collabPicture: json["userId"]['photo'],
      );

}