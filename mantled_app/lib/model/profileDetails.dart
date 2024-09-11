/// A class to hold my [CompleteProfile] model

class ProfileDetails {
  /// Constructor for [CompleteProfile] class
  ProfileDetails({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.paymentType,
    this.profilePic,
    this.paymentPrice,
    this.housingProperties,
    this.intangibleAssets,
    this.personalEffects,
    this.financialAssets,
  });
  String? id;
  String? fullName;
  String? profilePic;
  String? email;
  String? paymentPrice;
  String? paymentType;
  String? phoneNumber;
  int? housingProperties;
  int? financialAssets;
  int? intangibleAssets;
  int? personalEffects;

  factory ProfileDetails.fromJson(Map<String, dynamic> json) =>
      ProfileDetails(
        id: json["data"]["user"]["id"],
        email: json["data"]["user"]["email"],
        fullName: json["data"]["user"]["fullName"],
        phoneNumber: json["data"]["user"]["phoneNumber"],
        profilePic: json["data"]["user"]["photo"],
        personalEffects: json["personalEffects"],
        housingProperties:json["housingProperties"],
        financialAssets: json["financialAssets"],
        intangibleAssets: json["intangibleAssets"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "fullName": fullName,
    "phoneNumber": phoneNumber,
    "personalEffects": personalEffects,
    "housingProperties": housingProperties,
    "financialAssets": financialAssets,
    "intangibleAssets": intangibleAssets,
  };
}