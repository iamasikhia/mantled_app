/// A class to hold my [SignUpUser] model

class SignUpUser {
  /// Constructor for [SignUpUser] class
  SignUpUser({
    this.email,
    this.password,
    this.fullName,
    this.phoneNumber,
    this.message,
  this.numberVerification
  });

  /// A string variable to hold the users email
  String? email;

  /// A string variable to hold the users chosen password
  String? password;

  String? fullName;

  String? phoneNumber;

  int? numberVerification;

  /// A string variable to hold the users account role
  String? role;

  /// A string variable to hold the users first name
  String? firstName;

  /// A string variable to hold the users last name
  String? lastName;

  /// A string variable to hold the users token
  String? link;

  /// A string variable to hold the API call message
  String? message;

  /// Function to map user's info from a JSON object
  factory SignUpUser.map(
          Map<String, dynamic> json, var linkContent, String apiMessage) =>
      SignUpUser(
        email: json["email"],
        numberVerification: json["numberVerification"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        message: apiMessage,
      );

  test() {
    print(link);
  }

  /// Function to map user's details to a JSON object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["link"] = link ?? null;
    return map;
  }
}
