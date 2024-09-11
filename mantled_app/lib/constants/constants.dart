import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Constants {
  static const String POPPINS = "Poppins";
  static const String OPEN_SANS = "OpenSans";
  static const String SKIP = "Skip";
  static const String NEXT = "Next";
  static const String SLIDER_HEADING_1 = "Welcome to Delivery Connect!";
  static const String SLIDER_HEADING_2 = "Easy to Use!";
  static const String SLIDER_DESC =
      "Welcome to delivery connect, your one stop app for all your logistics needs.";

  /// Function to show error message with [_showAlert]
  static showError(BuildContext context, String message,
      {bool shouldDismiss = true}) {
    Timer.run(() => _showAlert(context, message, const Color(0xFFFDE2E1),
        Icons.error_outline, Colors.red, shouldDismiss));
  }

  /// Building a custom general dialog for my toast message with dynamic details
  static _showAlert(BuildContext context, String message, Color color,
      IconData icon, Color iconColor, bool shouldDismiss,
      {Function? where}) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          if (shouldDismiss) {
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(context, rootNavigator: true).pop();
            }).then((value) {
              if (icon == CupertinoIcons.check_mark_circled_solid) {
                where!();
              }
            });
          }
          return Material(
            type: MaterialType.transparency,
            child: WillPopScope(
              onWillPop: () async => false,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                              bottom: Radius.circular(10)),
                          color: color),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            icon,
                            size: 30,
                            color: iconColor,
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                message,
                                style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.black),
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ),
          );
        });
  }
}

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

const BASE_URL = "https://sentinel-production.up.railway.app/api/v1/";
const TEST_URL = "https://sentinel-production.up.railway.app/api/v1/";


