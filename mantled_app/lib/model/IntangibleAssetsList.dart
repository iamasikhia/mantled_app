/// A class to hold my [CompleteProfile] model

class IntangibleAssetsList {
  /// Constructor for [CompleteProfile] class
  IntangibleAssetsList({
    this.id,
    this.propName,
    this.assetType,
    this.createdDate,
    this.beneficiaryAddress,
    this.beneficiaryEmail,
    this.beneficiaryName,
    this.beneficiaryPhone,

  });
  String? id;
  String? propName;
  String? assetType;
  String? createdDate;
  String? beneficiaryName;
  String? beneficiaryRelationship;
  String? beneficiaryPhone;
  String? beneficiaryEmail;
  String? beneficiaryAddress;


  factory IntangibleAssetsList.fromJson(Map<String, dynamic> json) =>
      IntangibleAssetsList(
        id: json["id"],
        propName: json["title"],
        assetType:json["assetType"],
        createdDate: json["createdAt"],
        beneficiaryName: json["beneficiary"]["beneficiaryName"],
        beneficiaryEmail: json["beneficiary"]["beneficiaryEmail"],
        beneficiaryPhone: json["beneficiary"]["beneficiaryPhoneNumber"],
        beneficiaryAddress: json["beneficiary"]["beneficiaryAddress"]
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": propName,

    "fullName": createdDate,
  };
}


