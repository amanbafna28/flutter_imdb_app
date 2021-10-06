import 'package:flutter/material.dart';

class GlobalUtils {
  static navigateTo({BuildContext context, Widget screen}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  static pushReplace({BuildContext context, Widget screen}) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => screen));
  }

  static navigateAndRemoveUntil({BuildContext context, Widget screen}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => screen),
        (Route<dynamic> route) => false);
  }
}
