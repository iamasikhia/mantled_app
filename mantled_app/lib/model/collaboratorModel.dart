/// A class to hold my [CompleteProfile] model

class CollaboratorModel {
  /// Constructor for [CompleteProfile] class
  CollaboratorModel({
    this.fullName,
    this.emailAddress,
    this.realEstate,
    this.financialAssets,
    this.personalAssets,
    this.tangibleAssets,
    this.debtsAndLiabilities,
    this.others,
  });

  /// A string variable to hold the users email
  String? fullName;
  String? emailAddress;
  bool? realEstate;
  bool? financialAssets;
  bool? personalAssets;
  bool? tangibleAssets;
  bool? debtsAndLiabilities;
  bool? others;

}