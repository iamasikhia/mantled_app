import 'package:cloud_firestore/cloud_firestore.dart';

/// A class to hold my [CompleteProfile] model

class CompleteProfile {
  /// Constructor for [CompleteProfile] class
  CompleteProfile({
    this.dob,
    this.maritalStatus,
    this.childrenNum,
    this.nationality,
    this.nextOfKinName,
    this.nextOfKinEmail,
    this.nextOfKinPhone,
    this.message,
    this.paymentPlanAmount,
    this.paymentPlanText
  });

  /// A string variable to hold the users email
  String? dob;

  /// A string variable to hold the users chosen password
  String? maritalStatus;

  String? childrenNum;

  String? nationality;

  String? governmentID;

  /// A string variable to hold the users account role
  String? nextOfKinName;

  /// A string variable to hold the users first name
  String? nextOfKinEmail;

  /// A string variable to hold the users last name
  String? nextOfKinPhone;

  String? paymentPlanAmount;

  String? paymentPlanText;

  /// A string variable to hold the users token
  String? link;

  /// A string variable to hold the API call message
  String? message;

  /// Function to map user's info from a JSON object


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
