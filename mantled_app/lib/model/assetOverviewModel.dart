/// A class to hold my [CompleteProfile] model

class AssetOverviewModel {
  /// Constructor for [CompleteProfile] class
  AssetOverviewModel({

    this.realEstate,
    this.financialAssets,
    this.personalAssets,
    this.tangibleAssets,
    this.debtsAndLiabilities,
    this.others,
  });

  /// A string variable to hold the users email

  String? realEstate;
  String? financialAssets;
  String? personalAssets;
  String? tangibleAssets;
  String? debtsAndLiabilities;
  String? others;

}