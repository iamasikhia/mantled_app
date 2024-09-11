/// A class to hold my [CompleteProfile] model

class PersonalPropertyList {
  /// Constructor for [CompleteProfile] class
  PersonalPropertyList({
    this.id,
    this.propName,
    this.createdDate,
    this.beneficiaryRelationship,
    this.beneficiaryPhone,
    this.beneficiaryName,
    this.beneficiaryEmail,
    this.beneficiaryAddress,
    this.insuranceDocument,
    this.receiptDocument,
  });
  String? id;
  String? propName;
  String? createdDate;
  String? insuranceDocument;
  String? receiptDocument;
  String? beneficiaryName;
  String? beneficiaryRelationship;
  String? beneficiaryPhone;
  String? beneficiaryEmail;
  String? beneficiaryAddress;



factory PersonalPropertyList.fromJson(Map<String, dynamic> json) =>
      PersonalPropertyList(
        id: json["id"],
        propName: json["title"],
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


