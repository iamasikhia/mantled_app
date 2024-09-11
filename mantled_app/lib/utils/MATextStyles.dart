import 'package:flutter/material.dart';

double getHeight(double sysVar,double size){
  double calc=size/1000;
  return sysVar *calc;
}

double getTextSize(double sysVar,double size){
  double calc=size/10;
  return sysVar *calc;
}

class CustomTextStyle {
  static TextStyle primaryCustomTextStyle(BuildContext context, int size, Color color) {
    final textScale= MediaQuery.of(context).textScaleFactor;
    return Theme.of(context).textTheme.displayMedium!.copyWith(fontSize:size*textScale ,
      fontWeight: FontWeight.normal,
      color: color,);
  }

  static TextStyle primaryCustomTextStyle1(BuildContext context, ) {
    final textScale= MediaQuery.of(context).textScaleFactor;
    return Theme.of(context).textTheme.displayMedium!.copyWith(fontSize:16*textScale ,
      fontWeight: FontWeight.normal,
      color: Colors.black,);
  }

  static TextStyle semiBoldCustomTextStyle(BuildContext context, int size, Color color) {
    final textScale= MediaQuery.of(context).textScaleFactor;
    return Theme.of(context).textTheme.displayMedium!.copyWith(fontSize:size*textScale ,
      fontWeight: FontWeight.w500,
      color: color,);
  }

  static TextStyle boldCustomTextStyle(BuildContext context, int size, Color color ) {
    final textScale= MediaQuery.of(context).textScaleFactor;
    return Theme.of(context).textTheme.displayLarge!.copyWith(
        fontSize:size*textScale,
        color: color,
        fontWeight: FontWeight.bold );
  }

  static TextStyle boldCustomTextStyle1(BuildContext context, ) {
    final textScale= MediaQuery.of(context).textScaleFactor;
    return Theme.of(context).textTheme.displayLarge!.copyWith(
        fontSize:16*textScale,
        color: Colors.black,
        fontWeight: FontWeight.bold );
  }
  static TextStyle secondaryCustomTextStyle1(BuildContext context, ) {
    final textScale= MediaQuery.of(context).textScaleFactor;
    return Theme.of(context).textTheme.displayLarge!.copyWith(
        fontSize:14*textScale,
        color: Colors.black54,
        fontWeight: FontWeight.normal );
  }
  static TextStyle secondaryCustomStyle(BuildContext context, int size,  ) {
    final textScale= MediaQuery.of(context).textScaleFactor;
    return Theme.of(context).textTheme.displaySmall!.copyWith(
        fontSize:size*textScale,
        color:  Colors.black54,
        fontWeight: FontWeight.normal );
  }
}