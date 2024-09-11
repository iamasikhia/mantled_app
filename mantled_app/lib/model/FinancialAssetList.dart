/// A class to hold my [CompleteProfile] model

class FinancialAssetList {
  /// Constructor for [CompleteProfile] class
  FinancialAssetList({
    this.id,
    this.propName,
    this.createdDate,
    this.propTitle,
    this.propCountry,
    this.sharesHeld,
    this.brokers,
    this.nameRegisteredToStock,
    this.sharesByStock,
    this.shareLocation,
    this.stockHeld,
    this.stockType,
    this.beneficiaryAddress,
    this.beneficiaryEmail,
    this.beneficiaryName,
    this.beneficiaryPhone,
    this.beneficiaryRelationship,
  });
  String? id;
  String? propName;
  String? createdDate;
  String? propTitle;
  String? propCountry;
  int? sharesHeld;
  String? shareLocation;
  String? brokers;
  String? stockHeld;
  String? stockType;
  int? sharesByStock;
  String? nameRegisteredToStock;
  String? beneficiaryName;
  String? beneficiaryRelationship;
  String? beneficiaryPhone;
  String? beneficiaryEmail;
  String? beneficiaryAddress;

  factory FinancialAssetList.fromJson(Map<String, dynamic> json) =>
      FinancialAssetList(
        id: json["id"],
        propName: json["title"],
        createdDate: json["createdAt"],
        propCountry: json["country"],
        sharesHeld: json["sharesPercent"],
        shareLocation: json["sharesLocation"],
        brokers: json["brokers"],
        stockHeld: json["stocksHeld"],
        stockType: json["stocksType"],
        sharesByStock: json["numOfSharesPerStock"],
        nameRegisteredToStock: json["registeredTo"],
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


