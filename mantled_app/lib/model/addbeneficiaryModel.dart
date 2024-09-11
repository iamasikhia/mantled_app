/// A class to hold my [CompleteProfile] model

class AddBeneficiary {
  /// Constructor for [CompleteProfile] class
  AddBeneficiary({
    this.beneficiaryID,
    this.fullName,
    this.emailAddress,
    this.phoneNumber,
    this.createdAt,
  });

  /// A string variable to hold the users email
  String? fullName;
String? beneficiaryID;
  /// A string variable to hold the users chosen password
  String? emailAddress;

  String? phoneNumber;

  String? createdAt;


  factory AddBeneficiary.fromJson(Map<String, dynamic> json) =>
      AddBeneficiary(
        beneficiaryID: json['_id'],
        fullName: json['fullName'],
        emailAddress: json['email'],
        phoneNumber:  json['phoneNumber'],
        createdAt: json['createdAt'],
      );

}