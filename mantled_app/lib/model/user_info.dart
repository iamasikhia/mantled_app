/// A class to hold my [UserInfo] model

class UserInfo {
  /// Constructor for [UserInfo] class
  UserInfo({
    this.accessToken,
  });

  /// A string variable to hold the users token
  String? accessToken;

  /// Function to map user's info from a JSON object
  UserInfo.map(dynamic json) {
    accessToken = json["access_token"];
  }

  test() {
    print(accessToken);
  }

  /// Function to map user's details to a JSON object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["access_token"] = accessToken ?? null;
    return map;
  }
}
