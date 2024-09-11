/// A class to hold my [CompleteProfile] model

class HousePropertyList {
  /// Constructor for [CompleteProfile] class
  HousePropertyList({
    this.id,
    this.propName,
    this.createdDate,
    this.docType,
    this.propAddress,
    this.beneficiaryName,
    this.beneficiaryRelationship,
    this.beneficiaryPhone,
    this.beneficiaryAddress,
    this.beneficiaryEmail,



  });
  String? id;
  String? propName;
  String? createdDate;
  String? docType;
  String? propAddress;
  String? beneficiaryName;
  String? beneficiaryRelationship;
  String? beneficiaryPhone;
  String? beneficiaryEmail;
  String? beneficiaryAddress;



  factory HousePropertyList.fromJson(Map<String, dynamic> json) =>
      HousePropertyList(
        id: json["id"],
        propName: json["title"],
        createdDate: json["createdAt"],
        docType: json["documentType"],
        propAddress: json["propertyAddress"],
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


