/// A class to hold my [CompleteProfile] model

class PendingInvites {
  /// Constructor for [CompleteProfile] class
  PendingInvites({
    this.inviteName,
    this.inviteTime,
    this.inviteID,


  });

  String? inviteName;
  String? inviteTime;
  String? inviteID;


  factory PendingInvites.fromJson(Map<String, dynamic> json) =>
      PendingInvites(
          inviteName: json['fullName'],
          inviteTime: json['createdAt'],
          inviteID:  json['_id'],

      );



}
