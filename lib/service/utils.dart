import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Utils {
  static Future<void> navigateTo(
    BuildContext context,
    Widget screen, {
    bool fullScreenDialog = false,
    bool useRoot = false,
  }) async =>
      Navigator.of(context, rootNavigator: useRoot).push(MaterialPageRoute(
          builder: (context) => screen, fullscreenDialog: fullScreenDialog));

  static Future<void> replaceWith(BuildContext context, Widget screen) async {
    await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => screen));
  }

  static String formatTimestamp(DateTime timestamp) {
    return DateFormat('hh:mm a')
        .format(timestamp); // Formats time as "12:34 PM"
  }

  static Future<void> pushAndRemovePrevious(BuildContext context, Widget screen,
          {bool useRoot = false}) async =>
      Navigator.of(context, rootNavigator: useRoot).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => screen),
        (route) => false,
      );

  static void back(BuildContext context) => Navigator.pop(context);

  static Future<void> showToast(String message,
      {Toast toastLength = Toast.LENGTH_LONG}) async {
    var gravity = ToastGravity.BOTTOM;

    if (Platform.isIOS) {
      gravity = ToastGravity.TOP;
    }

    await Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: gravity,
      fontSize: 16.0,
      textColor: Colors.white,
    );
  }
}
