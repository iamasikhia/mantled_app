/// A class to hold my [UserCode] model

class UserCode {
  /// Constructor for [UserCode] class
  UserCode({
    this.userCode,
  });

  /// A string variable to hold the users token
  int? userCode;

  /// Function to map user's info from a JSON object
  UserCode.map(dynamic json) {
    userCode = json["code"];
  }

  test() {
    print(userCode);
  }

  /// Function to map user's details to a JSON object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["code"] = userCode ?? null;
    return map;
  }
}
