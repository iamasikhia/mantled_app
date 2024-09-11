import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:nb_utils/nb_utils.dart';
import 'package:mantled_app/utils/NBColors.dart';


Widget nbAppTextFieldWidget(TextEditingController controller,  String hintText,TextFieldType textFieldType, {FocusNode? focus, FocusNode? nextFocus}) {
  return AppTextField(
  textFieldType: textFieldType,
    controller: controller,

    textStyle:  primaryTextStyle(size: 15),
    textInputAction: TextInputAction.next,

      decoration: InputDecoration(
        contentPadding:const  EdgeInsets.only(left: 16, right: 16, top: 28, bottom: 28),
        filled: true,
        isDense: true,
        labelText: hintText,

        fillColor: Colors.white.withOpacity(0.1),
        hintText: hintText,

        border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.2) , width: 2),//border Color
        ),
        hintStyle: secondaryTextStyle(),
        enabledBorder:  OutlineInputBorder(
          borderRadius:  BorderRadius.circular(30.0),
          borderSide:  BorderSide(color: Colors.grey.withOpacity(0.2) ,width:2),

        ),
        focusedBorder: OutlineInputBorder(
          borderRadius:  BorderRadius.circular(30.0),
          borderSide:  const BorderSide(color:  NBPrimaryColor ,width: 2 ),

        ),
      )
  );
}

Widget nbAppButtonWidget(BuildContext context, String text, Function onTap) {
  return AppButton(
    text: text,
    textStyle: boldTextStyle(color: white),
    color: NBPrimaryColor,
    onTap: onTap,
    width: context.width(),
  ).cornerRadiusWithClipRRect(20);
}

AppBar nbAppBarWidget(BuildContext context, {String? title}) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Text('$title', style: boldTextStyle(color: black, size: 20)),
    backgroundColor: white,
  );

}

InputDecoration nbInputDecoration({IconData? prefixIcon, String? hint, Color? bgColor, Color? borderColor, EdgeInsets? padding}) {
  return InputDecoration(
      contentPadding: padding ?? const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      counter: const Offstage(),
      filled: true,
      hintText: hint,

      fillColor: Colors.white.withOpacity(0.1),
      hintStyle: secondaryTextStyle(),
      enabledBorder:  OutlineInputBorder(
        borderRadius:  BorderRadius.circular(30.0),
        borderSide:  BorderSide(color: Colors.grey.withOpacity(0.2) ,width:2),

      ),
      focusedBorder: OutlineInputBorder(
        borderRadius:  BorderRadius.circular(30.0),
        borderSide:  BorderSide(color:  Colors.grey.withOpacity(0.2) ,width: 2 ),
      )
  );
}


