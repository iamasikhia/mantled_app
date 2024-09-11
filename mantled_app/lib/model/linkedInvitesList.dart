/// A class to hold my [CompleteProfile] model

class LinkedInvitesList {
  /// Constructor for [CompleteProfile] class
  LinkedInvitesList({
    this.assetOwnerName,
    this.assetCount,
    this.assetOwnerID,


  });

  String? assetOwnerName;
  int? assetCount;
  String? assetOwnerID;



  factory LinkedInvitesList.fromJson(Map<String, dynamic> json) =>
      LinkedInvitesList(
        assetOwnerName: json['user'],
        assetCount: json['count'],
        assetOwnerID:  json['userId'],

      );



}
