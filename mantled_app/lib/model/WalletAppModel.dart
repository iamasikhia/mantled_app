import 'package:flutter/material.dart' hide ModalBottomSheetRoute;

class WAWalkThroughModel {
  String? title;
  String? description;
  String? image;

  WAWalkThroughModel({this.title, this.description, this.image});
}

class WARecentPayeesModel {
  String? image;
  String? name;
  String? number;

  WARecentPayeesModel({this.image, this.name, this.number});
}
class WADrawerItemModel {
  String? title;
  Widget? widget;

  WADrawerItemModel({this.title, this.widget});
}

class WACardModel {
  String? image;
  String? balance;
  String? cardNumber;
  String? date;
  Color? color;

  WACardModel({this.image, this.balance, this.cardNumber, this.date, this.color});
}

class WAOperationsModel {
  IconData? icon;
  Color? color;
  String? title;
  Widget? widget;

  WAOperationsModel({this.icon, this.color, this.title, this.widget});
}

class WATransactionModel {
  String? image;
  Color? color;
  String? title;
  String? name;
  String? time;
  String? balance;
  IconData? icon;
  WATransactionModel({this.image, this.icon, this.color, this.title, this.name, this.time, this.balance});
}

class WABillPayModel {
  String? image;
  String? title;
  Color? color;

  WABillPayModel({this.image, this.title, this.color});
}

class WAOrganizationModel {
  String? image;
  String? title;
  String? subTitle;
  Color? color;

  WAOrganizationModel({this.image, this.title, this.subTitle, this.color});
}

class WAWalletUserModel {
  String? image;

  WAWalletUserModel({this.image});
}

class WAVoucherModel{
  String? image;

  String? title;
  String? ticketSold;
  String? pointsText;

  WAVoucherModel({this.image, this.title, this.ticketSold, this.pointsText});
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}