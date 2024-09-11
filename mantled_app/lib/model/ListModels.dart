import 'package:flutter/material.dart' hide ModalBottomSheetRoute;

class ListModel {
  String? name;
  bool? isNew;
  Widget? widget;

  ListModel({this.name, this.widget,this.isNew});
}
