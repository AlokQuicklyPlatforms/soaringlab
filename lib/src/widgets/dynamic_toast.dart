import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DynamicToast {
  static void show(String message,
      {ToastGravity gravity = ToastGravity.BOTTOM}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: gravity,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
