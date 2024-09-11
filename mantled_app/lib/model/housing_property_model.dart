/// A class to hold my [CompleteProfile] model

class AssetModel {
  /// Constructor for [CompleteProfile] class
  AssetModel({
    this.propTitle,
    this.propAddressOne,
    this.propAddressTwo,
    this.assetType,
    this.countryName,
    this.localGov,
    this.stateName,
    this.personOwed,
    this.valueAmount,
    this.financialInstitution,
    this.accountManager,
    this.amount,
    this.cryptoType,
    this.platformName,
    this.pensionProvider,
    this.pensionType
  });

  /// A string variable to hold the users email
  String? propTitle;
  String? localGov;
  String? stateName;
  String? cryptoType;
  String? amount;
  String? financialInstitution;
  String? accountManager;
  String? countryName;
  String? propAddressOne;
  String? propAddressTwo;
  String? assetType;
  String? personOwed;
  String? platformName;
  int? valueAmount;
  String? pensionProvider;
  String? pensionType;
  String? insuranceCompany;
  String? insuranceType;


}