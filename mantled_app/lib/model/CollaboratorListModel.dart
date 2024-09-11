/// A class to hold my [CompleteProfile] model

class CollaboratorListModel {
  /// Constructor for [CompleteProfile] class
  CollaboratorListModel({
    this.collabID,
    this.collabName,
    this.collabPicture,

  });

  /// A string variable to hold the users email
  String? collabID;
  String? collabName;
  String? collabPicture;


  factory CollaboratorListModel.fromJson(Map<String, dynamic> json) =>
      CollaboratorListModel(
        collabID: json['_id'],
        collabName: json['fullName'],
        collabPicture: json['photo'],
      );

}